using Models.Dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Models.Common;
using StudentsManager.Models;
using Models.EntityFramework;
using System.Web.Script.Serialization;
using System.Data.SqlClient;

namespace StudentsManager.Controllers
{
    public class HomeController : BaseController
    {
        // GET: Home
        public ActionResult Index()
        {
            var classDao = new ClassDao();
            var data = classDao.GetObjectList();
            SelectList classList = new SelectList(data, "ClassId", "ClassName");
            ViewBag.ClassList = classList;
            return View();
        }

        [HttpGet]
        public JsonResult LoadData(int page, int pageSize, string classId)
        {
            var studClassDao = new StudentClassDao();
            var studDao = new StudentDao();
            var ListItem = studClassDao.GetObjectList(classId, CommonConstant.CLASSES); // lấy danh sách các studentId của các học sinh trong lớp classId
            var studList = new List<Student>(); // tạo bộ nhớ các học sinh
            foreach (var item in ListItem)// đổ dữ liệu vào danh sách
            {
                var stud = studDao.GetObject(item.StudId);
                stud.CreateAt = item.CreateAt;
                stud.UpdateAt = item.UpdateAt;
                studList.Add(stud);
            }
            var data = new StudentsModel().SetListStudentModel(studList); // chuyển kiểu từ Student thành StudentModel
            var className = new ClassDao().GetObject(classId).ClassName;
            var response = data.Item2.Skip((page - 1) * pageSize).Take(pageSize); // phân trang
            return Json(new
            {
                text = className,
                data = response,
                totalRow = data.Item1,
                status = true
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Delete(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            StudentClassModel studentclass = serializer.Deserialize<StudentClassModel>(data);
            var studclassDao = new StudentClassDao();
            studclassDao.DeleteObject(studentclass.StudId, studentclass.ClassId);
            return Json(new
            {
                status = true
            });
        }

        [HttpGet]
        public ActionResult Create()
        {
            var classDao = new ClassDao();
            var data = classDao.GetObjectList();
            SelectList classList = new SelectList(data, "ClassId", "ClassName");
            ViewBag.ClassList = classList;
            return View();
        }

        [HttpGet]
        public JsonResult LoadDropData(string classId)
        {
            object[] parameter =
            {
                new SqlParameter("@classId", classId),
            };
            var studDao = new StudentDao();
            var list = studDao.GetObjectList("MP_GetNot_StudentClass @classId", parameter);
            SelectList studList = new SelectList(list, "StudId", "FullName");
            var className = new ClassDao().GetObject(classId).ClassName;
            return Json(new {
                text = className,
                data = studList,
                status = true,
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Create(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            StudentClassModel model = serializer.Deserialize<StudentClassModel>(data);
            var studclassDao = new StudentClassDao();
            if (ModelState.IsValid)
            {
                if (!studclassDao.HasObject(model.ClassId, model.StudId))
                {
                    var studClassDao = new StudentClassDao();
                    studclassDao.AddObject(model.StudId, model.ClassId);
                }
            }
            return Json(new
            {
                status = true
            });
        }

        [HttpGet]
        public ActionResult Edit(string studId, string classId)
        {
            var classDao = new ClassDao();
            var studDao = new StudentDao();
            if (string.IsNullOrEmpty(studId) || !studDao.HasObject(studId) || string.IsNullOrEmpty(classId) || !classDao.HasObject(classId))
            {
                return RedirectToAction("index", "home");
            }
            object[] parameter =
            {
                new SqlParameter("@studId", studId),
            };
            var list = classDao.GetObjectList("MP_GetNot_ClassStudent @studId", parameter);
            SelectList classList = new SelectList(list, "ClassId", "ClassName");
            ViewBag.ClassList = classList;
            ViewBag.classOld = classId;
            var model = studDao.GetObject(studId);
            
            return View(model);
        }

        [HttpPost]
        public JsonResult Change(string data, string ClassId)
        {
            var serializer = new JavaScriptSerializer();
            StudentClassModel model = serializer.Deserialize<StudentClassModel>(data);
            var Dao = new StudentClassDao();
            Dao.UpdateObject(model.StudId, ClassId, model.ClassId);
            return Json(new {
                status = true,
            });
        }
    }
}