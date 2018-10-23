using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.EntityFramework;

namespace Models.Dao
{
    public class UserDao
    {
        private StudentsManagerDbContext db = null;
        public UserDao()
        {
            db = new StudentsManagerDbContext();
        }

        public List<User> GetObjectList()
        {
            return db.Users.ToList();
        }

        public User GetObject(string primary_key)
        {
            return db.Users.SingleOrDefault(obj => obj.UserName == primary_key);
        }

        // sử dụng store procedure
        public bool HasObject(string _cmd, object[] parameter)
        {
            return db.Database.SqlQuery<bool>(_cmd, parameter).SingleOrDefault();
        }
    }
}
