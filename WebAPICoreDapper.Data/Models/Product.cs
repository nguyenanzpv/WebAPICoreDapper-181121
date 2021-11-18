using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace WebAPICoreDapper.Data.Models
{
    public class Product
    {
        //ten giống với field database sẽ tự map
        public int Id { get; set; }

        [Required(ErrorMessage = "RequiredErrorMsg")]
        [StringLength(8, ErrorMessage = "MinAndMaxLengthErrorMsg", MinimumLength = 6)]
        public string Sku { get; set; }

        [Required(ErrorMessage = "RequiredErrorMsg")]
        public float Price { get; set; }

        public float? DiscountPrice { get; set; }

        public bool IsActive { get; set; }

        public string ImageUrl { get; set; }

        public int ViewCount { get; set; }

        public DateTime CreatedAt { get; set; }

        public string Name { get; set; }

        public string Content { get; set; }

        public string Description { get; set; }

        public string SeoAlias { get; set; }

        public string SeoDescription { get; set; }

        public string SeoTitle { get; set; }

        public string SeoKeyword { get; set; }

        public string CategoryIds { get; set; }//thêm/thay đổi mới nhiều giá trị 

        public string CategoryName { get; set; }

    }
}
