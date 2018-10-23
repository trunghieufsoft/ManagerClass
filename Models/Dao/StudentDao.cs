using Models.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using Models.Common;

namespace Models.Dao
{
    public class StudentDao
    {
        private StudentsManagerDbContext db = null;
        public StudentDao()
        {
            db = new StudentsManagerDbContext();
        }

        public List<Student> GetObjectList()
        {
            return db.Students.ToList();
        }
        public List<Student> GetObjectList(string search)
        {
            return db.Students.Where(c => c.StudId.Contains(search) || c.FullName.Contains(search)).ToList();
        }

        public Student GetObject(string primary_key)
        {
            return db.Students.SingleOrDefault(obj => obj.StudId == primary_key);
        }

        public bool HasObject(string primary_key)
        {
            return db.Students.Count(obj => obj.StudId == primary_key) > 0 ? true : false;
        }

        // using store procedure to get data list of Student
        public List<Student> GetObjectList(string proc, object[] parameter)
        {
            return db.Database.SqlQuery<Student>(proc, parameter).ToList();
        }

        public void AddObject(string studId, string name, bool gender, DateTime birthday, string address, string phone)
        {
            if (string.IsNullOrEmpty(phone))
                phone = "09xxx";
            var entity = new Student()
            {
                StudId = studId,
                FullName = name,
                Gender = gender,
                BirthDay = birthday,
                Address = address,
                Phone = phone,
                CreateAt = DateTime.Now,
                UpdateAt = DateTime.Now
            };
            db.Students.Add(entity);
            db.SaveChanges();
        }

        public void UpdateObject(string studId, string name, bool gender, DateTime birthday, string address, string phone)
        {
            var entity = GetObject(studId);
            entity.FullName = name;
            entity.Gender = gender;
            entity.BirthDay = birthday;
            entity.Address = address;
            entity.Phone = phone;
            db.SaveChanges();
        }

        public void DeleteObject(string studId)
        {
            var entity = new StudentClassDao();
            var objectList = entity.GetObjectList(studId, CommonConstant.STUDENTS);
            entity.DeleteObjectList(objectList);
            db.Students.Remove(GetObject(studId));
            db.SaveChanges();
        }
    }
}
