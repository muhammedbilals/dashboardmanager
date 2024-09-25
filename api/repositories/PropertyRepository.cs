using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.data;
using api.dtos.property;
using api.interfaces;
using api.mappers;
using api.models;
using Microsoft.EntityFrameworkCore;

namespace api.repositories
{
    public class PropertyRepository : IPropertyRepository
    {
        private readonly ApplicationDbContext _context;
        public PropertyRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<Property> CreateProperty(PropertyDto property)
        {
            var result = property.ToProperty();
            await _context.Properties.AddAsync(result);
            await _context.SaveChangesAsync();
            return result;
        }

        public async Task<Property?> DeleteProperty(int id)
        {
            var property = await GetPropertyById(id);

            if(property ==  null) return null;

            _context.Properties.Remove(property);
            await _context.SaveChangesAsync();

            return property;
        }

        public Task<List<Property>> GetProperties()
        {
            return _context.Properties.ToListAsync();
        }

        public async Task<Property?> GetPropertyById(int id)
        {
            return await _context.Properties.FirstOrDefaultAsync(s => s.Id == id );
        }

        public async Task<Property?> UpdateProperty(int id, PropertyDto property)
        {
            var result = await GetPropertyById(id);

            if(result == null) return null;

            result.PropertyName = property.PropertyName;
            result.PropertyType = property.PropertyType;
            result.Location = property.Location;
            result.Price = property.Price;
            result.SizeSqFt = property.SizeSqFt;
            result.NoOfBathrooms = property.NoOfBathrooms;
            result.NoOfBedrooms = property.NoOfBedrooms;

            await _context.SaveChangesAsync();

            return result;
        }
    }
}