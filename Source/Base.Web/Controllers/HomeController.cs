﻿using Base.Web.Core;
using System.Web.Mvc;

namespace Base.Web.Controllers
{
    public class HomeController : BaseController
    {
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }
    }
}