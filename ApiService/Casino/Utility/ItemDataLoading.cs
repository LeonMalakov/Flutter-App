using Casino.DAL.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.IO;

namespace Casino.Utility {
    public static class ItemDataLoading {
        public static bool TryLoad([MaybeNullWhen(false)] out List<Item> items) {
            try {
                var json = File.ReadAllText("statham.json");
                items = JsonSerialization.Deserialize<List<Item>>(json);
                return items != null;
            } catch (Exception) {
                items = null;
                return false;
            }
        }
    }
}
