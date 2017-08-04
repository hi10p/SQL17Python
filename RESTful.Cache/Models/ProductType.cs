using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RESTful.Cache.Models
{
    public class ProductType
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    public class ProductTypeCache:ProductType
    {
        public string Log { get; set; }

    }

}