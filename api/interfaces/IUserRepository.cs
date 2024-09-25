using System;
using System.Collections.Generic;
using System.Linq;

using api.models;

namespace api.interfaces
{
    public interface IUserRepository
    {
        public Task<List<User>> GetUsers();
        public  Task<User?> GetUserByEmail(string email);
        public  Task<User?> GetUserById(string Id);


    }
}