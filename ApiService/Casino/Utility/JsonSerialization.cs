using Newtonsoft.Json;

namespace Casino.Utility {
    public static class JsonSerialization {
        public static string Serialize<T>(T data) {
            var serializationSettings = CreateSettings();
            var json = JsonConvert.SerializeObject(data, serializationSettings);
            return json;
        }

        public static T? Deserialize<T>(string json) {
            var serializationSettings = CreateSettings();
            var dataRoot = JsonConvert.DeserializeObject<T>(json, serializationSettings);
            return dataRoot;
        }

        private static JsonSerializerSettings CreateSettings() {
            var serializationSettings = new JsonSerializerSettings() {
                DefaultValueHandling = DefaultValueHandling.Include,
                NullValueHandling = NullValueHandling.Ignore,

                // Test Only.
                //Formatting = Formatting.Indented
            };
            return serializationSettings;
        }
    }
}
