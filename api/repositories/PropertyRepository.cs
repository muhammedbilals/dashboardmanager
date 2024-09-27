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
        private readonly ApplicationDbContext _context; // Database context for accessing the database

        // Constructor for dependency injection
        public PropertyRepository(ApplicationDbContext context)
        {
            _context = context; // Assign the provided context to the private field
        }

        // Method to create a new property in the database
        public async Task<Property> CreateProperty(PropertyDto property)
        {
            // Convert the DTO to the Property entity
            var result = property.ToProperty();
            // Add the property entity to the context
            await _context.Properties.AddAsync(result);
            // Save changes to the database
            await _context.SaveChangesAsync();
            return result; // Return the created property
        }

        // Method to delete a property by its ID
        public async Task<Property?> DeleteProperty(int id)
        {
            // Retrieve the property by ID
            var property = await GetPropertyById(id);

            // Return null if the property does not exist
            if (property == null) return null;

            // Remove the property from the context
            _context.Properties.Remove(property);
            // Save changes to the database
            await _context.SaveChangesAsync();

            return property; // Return the deleted property
        }

        // Method to retrieve all properties
        public Task<List<Property>> GetProperties()
        {
            // Return the list of properties from the database
            return _context.Properties.ToListAsync();
        }

        // Method to retrieve a property by its ID
        public async Task<Property?> GetPropertyById(int id)
        {
            // Find and return the property with the specified ID, or null if not found
            return await _context.Properties.FirstOrDefaultAsync(s => s.Id == id);
        }

        // Method to update an existing property
        public async Task<Property?> UpdateProperty(int id, PropertyDto property)
        {
            // Retrieve the property by ID
            var result = await GetPropertyById(id);

            // Return null if the property does not exist
            if (result == null) return null;

            // Update the property fields with values from the DTO
            result.PropertyName = property.PropertyName;
            result.PropertyType = property.PropertyType;
            result.Location = property.Location;
            result.Price = property.Price;
            result.SizeSqFt = property.SizeSqFt;
            result.NoOfBathrooms = property.NoOfBathrooms;
            result.NoOfBedrooms = property.NoOfBedrooms;

            // Save changes to the database
            await _context.SaveChangesAsync();

            return result; // Return the updated property
        }
    }
}
