using System.Collections.Generic;

namespace Casino.Utility {
    public static class ArraySerializationUtility {
        public static bool TryDeserialize(string arr, out int[] result) {
            var itemIdStrs = arr.Split(',');

            result = new int[itemIdStrs.Length];

            for (int i = 0; i < itemIdStrs.Length; i++) {
                if (!int.TryParse(itemIdStrs[i], out int id)) {
                    return false;
                }
                result[i] = id;
            }
            return true;
        }

        public static string Serialize(IReadOnlyList<int> arr) {
            return string.Join(',', arr);
        }
    }
}
