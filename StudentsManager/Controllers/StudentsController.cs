using Models.Dao;
using StudentsManager.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace StudentsManager.Controllers
{
    public class StudentsController : BaseController
    {
        // GET: Students
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult LoadData(int page, int pageSize, bool isSearch, string search)
        {
            var studDao = new StudentDao();
            var listStudent = isSearch ?
                studDao.GetObjectList(search)
                :
                studDao.GetObjectList();
            var data = new StudentsModel().SetListStudentModel(listStudent);
            var response = data.Item2.Skip((page - 1) * pageSize).Take(pageSize);
            return Json(new
            {
                data = response,
                totalRow = data.Item1,
                status = true
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Delete(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            StudentsModel student = serializer.Deserialize<StudentsModel>(data);
            var studDao = new StudentDao();
            studDao.DeleteObject(student.StudId);
            return Json(new
            {
                status = true
            }, JsonRequestBehavior.AllowGet);
        }
        
        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public JsonResult Create(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            StudentsModel model = serializer.Deserialize<StudentsModel>(data);
            var studDao = new StudentDao();
            if (ModelState.IsValid)
            {
                if (!studDao.HasObject(model.StudId))
                {
                    DateTime date = DateTime.ParseExact(model.BirthDay, "dd/MM/yyyy", null);
                    studDao.AddObject(model.StudId, model.FullName, model.Gender, date, model.Address, model.Phone);
                }
                else
                {
                    ModelState.AddModelError("", "This class code already exists in the students list.");
                }
            }
            return Json(new
            {
                status = true,
            });
        }

        [HttpGet]
        public ActionResult Edit(string id)
        {
            var studDao = new StudentDao();
            if (string.IsNullOrEmpty(id) || !studDao.HasObject(id))
            {
                return RedirectToAction("index", "students");
            }
            var obj = studDao.GetObject(id);
            var model = new StudentsModel()
            {
                StudId = obj.StudId,
                FullName = obj.FullName,
                Address = obj.Address,
                BirthDay = obj.BirthDay.ToString("dd/MM/yyyy"),
                Gender = obj.Gender,
                Phone = obj.Phone,
                CreateAt = obj.CreateAt.ToString("dd/MM/yyyy"),
                UpdateAt = obj.UpdateAt.ToString("dd/MM/yyyy")
            };
            return View(model);
        }

        [HttpPost]
        public JsonResult Update(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            StudentsModel model = serializer.Deserialize<StudentsModel>(data);
            var studDao = new StudentDao();
            var obj = studDao.GetObject(model.StudId);
            if (ModelState.IsValid)
            {
                DateTime date = DateTime.ParseExact(model.BirthDay, "dd/MM/yyyy", null);
                studDao.UpdateObject(model.StudId, model.FullName, model.Gender, date, model.Address, model.Phone);
            }
            return Json(new
            {
                status = true,
            });
        }
    }
}