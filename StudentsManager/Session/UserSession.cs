using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StudentsManager.Session
{
    public class UserSession
    {
        public string UserName { get; set; }

        public bool RememberMe { get; set; }
    }
}