using Models.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Models.Dao
{
    public class StudentClassDao
    {
        private StudentsManagerDbContext db = null;
        public StudentClassDao()
        {
            db = new StudentsManagerDbContext();
        }

        public List<StudentClass> GetObjectList(string primary_key, bool type)
        {
            return type?
                 db.StudentClasses.Where(o => o.StudId == primary_key).ToList() 
                 :
                 db.StudentClasses.Where(o => o.ClassId == primary_key).ToList();
        }
        

        public void DeleteObjectList(List<StudentClass> obj)
        {
            foreach(var item in obj)
                db.StudentClasses.Remove(item);
            db.SaveChanges();
        }
        
        public List<StudentClass> GetObjectList()
        {
            return db.StudentClasses.ToList();
        }

        public StudentClass GetObject(string class_key, string stud_key)
        {
            return db.StudentClasses.SingleOrDefault(obj => obj.StudId == stud_key && obj.ClassId == class_key);
        }

        public bool HasObject(string class_key, string stud_key)
        {
            return db.StudentClasses.Count(obj => obj.StudId == stud_key && obj.ClassId == class_key) > 0 ? true : false;
        }

        // using store procedure to get data list of Student
        public List<StudentClass> GetObjectList(string proc, object[] parameter)
        {
            return db.Database.SqlQuery<StudentClass>(proc, parameter).ToList();
        }

        public void AddObject(string studId, string classId)
        {
            var entity = new StudentClass()
            {
                StudId = studId,
                ClassId = classId,
                CreateAt = DateTime.Now,
                UpdateAt = DateTime.Now
            };
            db.StudentClasses.Add(entity);
            db.SaveChanges();
        }

        public void UpdateObject(string studId, string classId, string newClassId)
        {
            var entity = GetObject(classId, studId);
            var entity2 = new StudentClass()
            {
                StudId = studId,
                ClassId = newClassId,
                CreateAt = entity.CreateAt,
                UpdateAt = DateTime.Now
            };
            db.StudentClasses.Add(entity2);
            db.StudentClasses.Remove(entity);
            db.SaveChanges();
        }

        public void DeleteObject(string studId, string classId)
        {
            var entity = GetObject(classId, studId);
            db.StudentClasses.Remove(entity);
            db.SaveChanges();
        }
    }
}
