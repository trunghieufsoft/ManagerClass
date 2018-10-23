using Models.Common;
using Models.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Models.Dao
{
    public class ClassDao
    {
        private StudentsManagerDbContext db = null;
        public ClassDao()
        {
            db = new StudentsManagerDbContext();
        }

        public List<Class> GetObjectList()
        {
            return db.Classes.ToList(); // select * from abc
        }

        public List<Class> GetObjectList(string search)
        {
            return db.Classes.Where(c => c.ClassName.Contains(search) || c.ClassId.Contains(search)).ToList();
        }

        public Class GetObject(string primary_key)
        {
            return db.Classes.SingleOrDefault(obj => obj.ClassId == primary_key);
        }

        public bool HasObject(string primary_key)
        {
            return db.Classes.Count(obj => obj.ClassId == primary_key) > 0 ? true : false;
        }

        // using store procedure to get data list of Student
        public List<Class> GetObjectList(string proc, object[] parameter)
        {
            return db.Database.SqlQuery<Class>(proc, parameter).ToList();
        }

        public void AddObject(string classId, string className)
        {
            var entity = new Class()
            {
                ClassId = classId,
                ClassName = className,
                CreateAt = DateTime.Now,
                UpdateAt = DateTime.Now
            };
            db.Classes.Add(entity);
            db.SaveChanges();
        }

        public void UpdateObject(string classId, string className)
        {
            var entity = GetObject(classId);
            entity.ClassName = className;
            db.SaveChanges();
        }

        public void DeleteObject(string classId)
        {
            var entity = new StudentClassDao();
            var objectList = entity.GetObjectList(classId, CommonConstant.CLASSES);
            entity.DeleteObjectList(objectList);
            db.Classes.Remove(GetObject(classId));
            db.SaveChanges();
        }
    }
}
