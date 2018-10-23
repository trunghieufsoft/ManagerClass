using Models.Common;
using Models.Common.Encode;
using Models.Dao;
using Models.EntityFramework;
using StudentsManager.Models;
using StudentsManager.Session;
using System.Data.SqlClient;
using System.Web.Mvc;

namespace StudentsManager.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(UserModel model)
        {
            if (ModelState.IsValid)
            {
                var userDao = new UserDao();
                object[] parameter =
                {
                    new SqlParameter("@uname", model.UserName),
                    new SqlParameter("@passwd", Encrypt.Encrypt_Code(model.Password))
                };
                var res = userDao.HasObject("MP_User_Login @uname, @passwd", parameter);
                if (res)
                {
                    User entity = userDao.GetObject(model.UserName);
                    if (entity.isActive)
                    {
                        var userSession = new UserSession()
                        {
                            UserName = model.UserName,
                            RememberMe = model.RememberMe
                        };
                        Session.Add(CommonConstant.USER_SESSION, userSession);
                        return RedirectToAction("Index", "Home");
                    }
                    else
                    {
                        ModelState.AddModelError("", "Account is locked!");
                    }
                }
                else
                {
                    ModelState.AddModelError("", "Incorrect Account!");
                }
            }
            else
            {
                if (string.IsNullOrEmpty(model.UserName))
                    ModelState.AddModelError("", "Please enter username!");
                if (string.IsNullOrEmpty(model.Password))
                    ModelState.AddModelError("", "Please enter password!");
            }

            return View(model);
        }
        [HttpGet]
        public ActionResult Logout()
        {
            Session.RemoveAll();
            return RedirectToAction("Index", "Login");
        }
    }
}