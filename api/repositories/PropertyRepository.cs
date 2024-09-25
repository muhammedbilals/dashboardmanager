using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.data;
using api.interfaces;
using api.models;

namespace api.repositories
{
    public class PropertyRepository : IPropertyRepository
    {
        private readonly ApplicationDbContext _context;
        public PropertyRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public Task<Property> CreateProperty(Property property)
        {
            throw new NotImplementedException();
        }

        public Task<Property> DeleteProperty(int id)
        {
            throw new NotImplementedException();
        }

        public Task<List<Property>> GetProperties()
        {
            throw new NotImplementedException();
        }

        public Task<Property> GetPropertyById(int id)
        {
            throw new NotImplementedException();
        }

        public Task<Property> UpdateProperty(int id, Property property)
        {
            throw new NotImplementedException();
        }
    }
}