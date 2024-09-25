using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;


namespace api.dtos.user
{

    public class RegisterDto
    {
        [Required]
        [EmailAddress]
        public string? Email{get; set;}
        [Required]
        public string? Password{get; set;}
        
    }
}