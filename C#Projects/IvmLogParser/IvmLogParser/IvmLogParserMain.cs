using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;

namespace IvmPKeyViolationTracker {
    internal class Program {
        private static string logFile = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location),  
            @"Data\DataManager-2018-10-11.log");

        private static Dictionary<string, int> dataSet = new Dictionary<string, int>();
        private static Dictionary<string, int> dataSetOut = new Dictionary<string, int>();

        private static void Main(string[] args) {
            try {
                //Parse the log file to build a dictionary of dataset IDs with a count of number of duplications
                parseLogFile(logFile, ref dataSet);

                // Perform a query to get the property name and datasource for each dataset ID
                queryDataSetInfo(ref dataSet, ref dataSetOut);

                var list = dataSetOut.Keys.ToList();
                list.Sort();
                foreach (var key in list)
                {
                    Console.WriteLine("DataSource,PropertyName,PKeyViolations");
                    Console.WriteLine("{0}, {1}", key, dataSetOut[key]);
                }
            }
            catch (Exception e) {
                Console.WriteLine("Trapped exception: " + e.Message);
            }

            Console.Write("Press any key to terminate...");
            Console.ReadKey();
        }


        static private void queryDataSetInfo(ref  Dictionary<string, int> dataSet, ref Dictionary<string, int> dataSetOut)
        {
            var conn = new SqlConnection("Server=houmsivmsql002\\IVMSQLPRD;Database = IVMPetexDP;User Id = RO_DOF; Password = R3@dOn1y");
            var dataSetIds = String.Join(",", dataSet.Keys.ToArray());

            string sql_query = @"SELECT LTRIM(STR(DataSetId)) AS DataSetId, ObjectTypePropertyName, DataSourceName 
                                 FROM IVMPetexDP.ext.vw_CurrentValues 
                                 WHERE DataSetId IN (" + dataSetIds + ")";


            //Console.WriteLine("DataSetIDs={0}", dataSetIds);

           // Execute the query
            using (SqlCommand cmd = new SqlCommand(sql_query, conn))
            {
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            var dataSetId = reader.GetString(0);
                            var propertyName = reader.GetString(1);
                            var dataSource = reader.GetString(2);
                            var key = dataSource + "," + propertyName;

                            if (dataSetOut.TryGetValue(key, out int dupCnt)) {
                                dataSetOut[key] += dataSet[dataSetId];

                                //Console.WriteLine("DataSetId={0}  Current={1}  CurrentTotal={2}  DataSetCnt={3}", 
                                //    dataSetId, dupCnt, dataSetOut[key],
                                //    dataSet[dataSetId]);
                            }
                            else {
                                dataSetOut[key] = dataSet[dataSetId];

                                //Console.WriteLine("PRIMING DATAOUT:  DataSetId={0}  'KEY={1}'  DupCntRaw={2}   DupCntDict={3}",
                                //    dataSetId, propertyName + "," + dataSource, dupCnt, dataSetOut[key]);

                            }
                            //Console.WriteLine("DataSetId[0]='{0}'  [PropertyName]='{1}'  [DataSource]='{2}'", dataSetId, propertyName, dataSource);
                            //Console.WriteLine("{0},   {1},   {2},   {3}", dataSetId, dataSet[dataSetId], propertyName, dataSource);
                        }
                    }
                }
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="logFile"></param>
        /// <param name="dataSet"></param>
        /// <returns></returns>
        static private void parseLogFile(string logFile, ref Dictionary<string, int> dataSet) {
            // Test to make sure the log file exists and if so part it out looking for all references
            // to PRIMARY KEY violations and tally them up
            if (File.Exists(logFile)) {
                // Open the stream and read it back.
                using (StreamReader sr = File.OpenText(logFile)) {
                    string s;

                    while ((s = sr.ReadLine()) != null) {
                        if (s.Contains(@"PRIMARY KEY constraint violations")) {
                            // Define a regular expression for to extract the relative data
                            Regex rx = new Regex(@"DataSet\s+(?<DataSetID>\d+)\s+\w+\s+(?<ErrCnt>\d+)",
                              RegexOptions.Compiled | RegexOptions.IgnoreCase);
                            var results = rx.Matches(s);

                            // Map the corresponding matched results into the referenced dictionary
                            foreach (Match match in results) {
                                if (dataSet.TryGetValue(match.Groups["DataSetID"].Value, out int errCnt)) {
                                    //Console.WriteLine("*** FOUND DataSetID: {0}  curVal={1}  newVal={2}  TotCnt={3}",
                                    //    match.Groups["DataSetID"].Value, errCnt,
                                    //    match.Groups["ErrCnt"].Value,
                                    //    errCnt + System.Convert.ToInt32(match.Groups["ErrCnt"].Value));
                                    dataSet[match.Groups["DataSetID"].Value] =
                                        errCnt + System.Convert.ToInt32(match.Groups["ErrCnt"].Value);
                                } else {
                                    dataSet[match.Groups["DataSetID"].Value] =
                                        System.Convert.ToInt32(match.Groups["ErrCnt"].Value);
                                }
                            }
                        }
                    }
                }
            }
        } // parseLogFile()
    }
} // namespace IvmPKeyViolationTracker


