using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication.CacheClient;
using WebApplication.Model;

namespace WebApplication.Controllers
{
    public class CatalogController : Controller
    {
        // GET: Product type catalog 
        public ActionResult Show()
        {
            return View();
        }
        public ActionResult Reload()
        {
            List<ProductType> types = ProductTypeCache.GetAll();
            return View(types);
        }
        // Save product type
        public ActionResult Update(string Name)
        {
            if(!string.IsNullOrEmpty(Name))
                ProductTypeData.Update(Name);

            return RedirectToAction("Show");
        }

    }
}