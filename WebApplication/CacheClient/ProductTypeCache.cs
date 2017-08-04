using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using WebApplication.Model;

namespace WebApplication.CacheClient
{
    public class ProductTypeCache
    {
        private static string ProductTypeCacheRestUrl = string.Empty;
        static ProductTypeCache()
        {
            ProductTypeCacheRestUrl = ConfigurationManager.AppSettings["RESTful.ProductType"].ToString();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static List<ProductType> GetAll()
        {
            List<ProductType> result = null;
            HttpWebRequest request = WebRequest.Create(Path.Combine( ProductTypeCacheRestUrl,"GetAll")) as HttpWebRequest;
            request.Method = "GET";
            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            using (StreamReader reader = new StreamReader(response.GetResponseStream()))
            {
                if (response.StatusCode == HttpStatusCode.InternalServerError || response.StatusCode == HttpStatusCode.NotFound)
                {
                    throw new Exception(string.Format("HTTP:{0} ,", response.StatusCode, reader.ReadToEnd()));
                }
                result = JsonConvert.DeserializeObject<List<ProductType>>(reader.ReadToEnd());
            }
            return result;
        }
    }
}