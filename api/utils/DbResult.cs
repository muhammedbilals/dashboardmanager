using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.models;

namespace api.utils
{
    public class DbResult<T>
    {
        public bool Success { get; set; }
        public string? Message { get; set; }
        public T? Data { get; set; }

        public static DbResult<T> Failure(string message) => new DbResult<T> { Success = false, Message = message };
        public static DbResult<T> SuccessResult(T data) => new DbResult<T> { Success = true, Data = data };

        // internal DbResult<College> SuccessResult(College college)
        // {
        //     throw new NotImplementedException();
        // }
    }
}