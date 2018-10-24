using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;

namespace IvmPKeyViolationTracker {
    internal class Program {
        private static readonly string csvFileName = @"PKeyViolationSummary.csv";
        //private static readonly string logFile = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), logFileName);

        private static readonly string sqlServerConnStr =
            "Server=houmsivmsql002\\IVMSQLPRD;Database = IVMPetexDP;User Id = RO_DOF; Password = R3@dOn1y";

        private static Dictionary<string, int> dataSetIds = new Dictionary<string, int>();
        private static Dictionary<string, int> pkeyViolations = new Dictionary<string, int>();

        /// <summary>
        /// IvmPKeyViolationTracker 
        ///     Main program entry point.
        /// </summary>
        /// <param name="args"></param>
        private static void Main(string[] args) {
            try {
                string logFileName = null;

                switch (args.Length) {
                    case 0:
                        // No file specified so generate default name using current date
                        logFileName = "DataManager-" + DateTime.Now.ToString("yyyy-MM-dd");
                        break;
                    case 1:
                        // Use the specified name
                        logFileName = args[0];
                        brake;
                    default:
                        // Not sure what the user is doing to flag an error
                        Console.WriteLine("\n\nUsage: {0} <IVM DataManager Logfile>\n\nDataManager log file was not specified!\n" +
                            "Press any key to terminate.",
                            System.AppDomain.CurrentDomain.FriendlyName);
                        System.Environment.Exit(1);
                }

                Console.WriteLine("Processing " + logFileName + "...");

                //Parse the log file to build a dictionary of dataset IDs with a count of number of duplications
                parseLogFile(logFileName, ref dataSetIds);

                // Perform a query to get the property name and datasource for each dataset ID
                processQuery(ref dataSetIds, ref pkeyViolations);

                using (StreamWriter swf = new StreamWriter("pkeyViolationSummary.csv")) {
                    swf.WriteLine("DataSource,PropertyName,PKeyViolations");

                    foreach (var pkv in pkeyViolations.OrderBy(pkv => pkv.Key)) {
                        swf.WriteLine("{0}, {1}", pkv.Key, pkv.Value);
                    }
                }

                Console.WriteLine("Processing Completed.\nCSV file '" + csvFileName + "' created.\nPress any key to terminate...");
                Console.ReadKey();
            }
            catch (Exception e) {
                Console.WriteLine("Trapped exception: " + e.Message);
            }
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="dataSet"></param>
        /// <param name="dataSetOut"></param>
        private static void processQuery(ref Dictionary<string, int> dataSet, ref Dictionary<string, int> dataSetOut) {
            // Connection to the SQL server on which to run the query
            var conn = new SqlConnection(sqlServerConnStr);

            // This creates a comma separate list of dataset ids to use in the where clause of the query
            var dataSetIds = String.Join(",", dataSet.Keys.ToArray());

            // Create the query string
            string sqlQuery = @"SELECT 
                                    LTRIM(STR(DataSetId)) AS DataSetId, ObjectTypePropertyName, DataSourceName 
                                 FROM 
                                    IVMPetexDP.ext.vw_CurrentValues 
                                 WHERE 
                                    DataSetId IN (" + dataSetIds + ")";

            // Execute the query
            using (SqlCommand cmd = new SqlCommand(sqlQuery, conn)) {
                cmd.Connection.Open();
                using (SqlDataReader reader = cmd.ExecuteReader()) {
                    if (reader.HasRows) {
                        while (reader.Read()) {
                            var dataSetId = reader.GetString(0);
                            var propertyName = reader.GetString(1);
                            var dataSource = reader.GetString(2);
                            var key = dataSource + "," + propertyName;

                            if (dataSetOut.TryGetValue(key, out int dupCnt)) {
                                dataSetOut[key] += dataSet[dataSetId];
                            } else {
                                dataSetOut[key] = dataSet[dataSetId];
                            }
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
        private static void parseLogFile(string logFile, ref Dictionary<string, int> dataSet) {
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


