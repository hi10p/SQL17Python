using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RESTful.Cache.Models
{
    public class CacheUpdateResult
    {
        public int Id { get; set; }
        public DateTime CachedOn { get; set; }
        public string OnServer { get; set; }
    }
}