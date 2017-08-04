using System.Web.Http;
using RESTful.Cache.Models;
using System.Collections.Generic;
using System;
using System.Web;
using System.Net;

namespace RESTful.Cache.Controllers
{
    public class ProductTypeController : ApiController
    {
        /// <summary>
        /// JSON list having vehicles admited for repair and fixes
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public IHttpActionResult UpdateCache(ProductType product)
        {
            //New product type created on host(server)
            CacheUpdateResult result = new CacheUpdateResult() {
                Id = product.Id, CachedOn = DateTime.Now,
                OnServer = Dns.GetHostName()
            };
            //And cached with product type
            ProductTypeCacheStore.Add(product, result);
            return Ok(result);
        }

        /// <summary>
        /// Get all product types
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public IHttpActionResult GetAllProductTypes()
        {
            List<ProductTypeCache> result = ProductTypeCacheStore.GetAll();
            return Ok(result);
        }
    }
}
