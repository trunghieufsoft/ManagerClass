using Models.Common;
using StudentsManager.Session;
using System.Web.Mvc;
using System.Web.Routing;

namespace StudentsManager.Controllers
{
    public class BaseController : Controller
    {
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var session = (UserSession)Session[CommonConstant.USER_SESSION];
            if (session == null)
            {
                filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new { controller = "login", action = "index" }));
            }
            base.OnActionExecuting(filterContext);
        }
    }
}