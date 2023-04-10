const mongoose = require("mongoose");

const category = mongoose .model(
  "Category"  ,
  mongoose.Schema(
    {
        categoryName:
        {
          type:String,
          required: true,
          unique: true,
        },
        categoryImage:
        {
            type:String
        },
    },
    {
        toJSON: {
          transform: (doc, ret) => {
            ret.categoryId = ret._id.toString();
            delete ret._id;
            delete ret.__v;
          },
        },
    }
  )
);

module.exports ={
    category
}