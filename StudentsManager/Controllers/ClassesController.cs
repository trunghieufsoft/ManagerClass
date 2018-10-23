using System;
using Models.Dao;
using StudentsManager.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using Models.EntityFramework;
using System.Data.SqlClient;

namespace StudentsManager.Controllers
{
    public class ClassesController : BaseController
    {
        // GET: Classes
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult LoadData(int page, int pageSize, bool isSearch, string search)
        {
            var classDao = new ClassDao();
            var listStudent = isSearch ?
                classDao.GetObjectList(search)
                :
                classDao.GetObjectList();
            var data = new ClassModel().SetListClassModel(listStudent);
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
            ClassModel classes = serializer.Deserialize<ClassModel>(data);
            var classDao = new ClassDao();
            classDao.DeleteObject(classes.ClassId);
            return Json(new
            {
                status = true
            });
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public JsonResult Create(string data)
        {
            if (ModelState.IsValid)
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                ClassModel model = serializer.Deserialize<ClassModel>(data);
                var classDao = new ClassDao();
                if (!classDao.HasObject(model.ClassId))
                {
                    classDao.AddObject(model.ClassId, model.ClassName);
                }
                else
                {
                    ModelState.AddModelError("", "This class code already exists in the classes list.");
                }
            }
            return Json(new
            {
                status = true
            });
        }

        [HttpGet]
        public ActionResult Edit(string id)
        {
            var classDao = new ClassDao();
            if (string.IsNullOrEmpty(id) || !classDao.HasObject(id))
            {
                return RedirectToAction("index", "classes");
            }
            var obj = classDao.GetObject(id);
            var model = new ClassModel()
            {
                ClassId = obj.ClassId,
                ClassName = obj.ClassName,
                StudTotal = obj.StudTotal,
                CreateAt = obj.CreateAt.ToString("dd/MM/yyyy"),
                UpdateAt = obj.UpdateAt.ToString("dd/MM/yyyy")
            };
            return View(model);
        }

        [HttpPost]
        public JsonResult Update(string data)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ClassModel model = serializer.Deserialize<ClassModel>(data);
            var classDao = new ClassDao();
            var obj = classDao.GetObject(model.ClassId);
            if (ModelState.IsValid)
            {
                classDao.UpdateObject(model.ClassId, model.ClassName);
            }
            return Json(new
            {
                status = true
            });
        }
    }
}