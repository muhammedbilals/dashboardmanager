using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.data;
using api.interfaces;
using api.models;
using Microsoft.EntityFrameworkCore;

namespace api.repositories
{
    public class UserRepository : IUserRepository
    {

        private readonly ApplicationDbContext _context;
        public UserRepository(ApplicationDbContext context)
        {
            _context =context;
        }

        public async Task<User?> GetUserByEmail(string email)
        {
           return await _context.Users.FirstOrDefaultAsync(u => u.Email == email);
        }

        public async Task<User?> GetUserById(string Id)
        {
           return await _context.Users.FirstOrDefaultAsync(u => u.Id == Id);
        }

        public Task<List<User>> GetUsers()
        {
           return _context.Users.ToListAsync();
        }
    }
}