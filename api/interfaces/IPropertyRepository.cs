using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.dtos.property;
using api.models;

namespace api.interfaces
{
    public interface IPropertyRepository
    {
        public Task<Property?> GetPropertyById(int id);
        public Task<List<Property>> GetProperties();
        public Task<Property> CreateProperty(PropertyDto property);
        public Task<Property?> UpdateProperty(int id , PropertyDto property);
        public Task<Property?> DeleteProperty(int id);
    }
}