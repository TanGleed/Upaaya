const categoriesservice= require ("../services/category.services");
const upload = require("../middleware/category.middleware");


//create category
exports.create = (req, res, next) => {

    upload(req, res, function (err) {
      if (err) {
        console.log(err);
        next(err);
      } else {
        const path =
          req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";
  
        var model = {
          categoryName: req.body.categoryName,
          categoryDescription: req.body.categoryDescription,
          categoryImage: path != "" ? "/" + path : "",
        };
  
        categoriesservice.createCategory(model, (error, results) => {
          if (error) {
            console.log(error);
            return next(error);
          } else {
            return res.status(200).send({
              message: "Succes",
              data: results,
            });
          }
        });
      }
    });
}

//getcategories
exports.findAll = (req, res, next) => {
    var model = {
      categoryName: req.query.categoryName,
      PageSize: req.query.PageSize,
      page: req.query.page,
    };
  
    categoriesservice.getCategories(model, (error, results) => {
      if (error) {
        return next(error);
      } else {
        return res.status(200).send({
          message: "Succes",
          data: results,
        });
      }
    });
};


exports.findOne = (req, res, next) => {
    var model = {
      categoryId: req.params.id,
    };
  
    categoriesservice.getCategoryById(model, (error, results) => {
      if (error) {
        return next(error);
      } else {
        return res.status(200).send({
          message: "Succes",
          data: results,
        });
      }
    });
  };
//update category
exports.update = (req, res, next) => {
    upload(req, res, function (err) {
      if (err) {
        next(err);
      } else {
        const path =
          req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";
  
        var model = {
          categoryId: req.params.id,
          categoryName: req.body.categoryName,
          categoryDescription: req.body.categoryDescription,
          categoryImage: path != "" ? "/" + path : "",
        };
  
        categoriesservice.updateCategory(model, (error, results) => {
          if (error) {
            return next(error);
          } else {
            return res.status(200).send({
              message: "Succes",
              data: results,
            });
          }
        });
      }
    });
};

//delete
exports.delete = (req, res, next) => {
    var model = {
      categoryId: req.params.id,
    };
  
    categoriesservice.deleteCategory(model, (error, results) => {
      if (error) {
        return next(error);
      } else {
        return res.status(200).send({
          message: "Succes",
          data: results,
        });
      }
    });
  };