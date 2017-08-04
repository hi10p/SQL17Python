using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RESTful.Cache.Models
{
    public class ProductTypeCacheStore
    {
        private static readonly List<ProductTypeCache> CacheStore;

        //Initate cache store
        static ProductTypeCacheStore()
        {
            CacheStore = new List<ProductTypeCache>();
        }

        /// <summary>
        /// Add product type in cache
        /// </summary>
        /// <param name="productType"></param>
        /// <returns></returns>
        public static bool Add(ProductTypeCache productType)
        {
            try
            {
                CacheStore.Add(productType);
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }

        internal static bool Add(ProductType product, CacheUpdateResult result)
        {
            try
            {
                CacheStore.Add(new ProductTypeCache { Id=product.Id,Name=product.Name,Log = $"[{result.OnServer}] cached on '{result.CachedOn}'" });
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// Get all cached product types
        /// </summary>
        /// <returns></returns>
        public static List<ProductTypeCache> GetAll()
        {
            return CacheStore;
        }

        /// <summary>
        /// Get ProductType by Name
        /// </summary>
        /// <param name="Name"></param>
        /// <returns></returns>
        public static ProductTypeCache GetBy(string Name)
        {
            return CacheStore.FindLast(X => X.Name == Name);
        }

        /// <summary>
        /// Get ProductType by Id
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        public static ProductTypeCache GetBy(int Id)
        {
            return CacheStore.FindLast(X => X.Id == Id);
        }
    }
}