using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using api.dtos.property;
using api.models;

namespace api.mappers
{
    public static class PropertyMappers
    {
        public static PropertyDto ToPropertyDto (this Property property){
            return new PropertyDto{
                PropertyName = property.PropertyName,
                PropertyType = property.PropertyName,
                Location = property.PropertyName,
                Price = property.Price,
                NoOfBathrooms = property.NoOfBathrooms,
                NoOfBedrooms = property.NoOfBedrooms,
                SizeSqFt = property.SizeSqFt,
            };
        }
        public static Property ToProperty(this PropertyDto property){
            return new Property{
                
                PropertyName = property.PropertyName,
                PropertyType = property.PropertyName,
                Location = property.PropertyName,
                Price = property.Price,
                NoOfBathrooms = property.NoOfBathrooms,
                NoOfBedrooms = property.NoOfBedrooms,
                SizeSqFt = property.SizeSqFt,
            };
        }
    }
}