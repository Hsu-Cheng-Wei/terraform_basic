using System;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace Pumpkin.VR_CMS.CloudWatch.MediaConvert.Lambda
{
    public class EnumJsonConverter<T> : JsonConverter<T>
    {
        public override T Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            var str = reader.GetString();

            return (T)Enum.Parse(typeof(T), str);
        }

        public override void Write(Utf8JsonWriter writer, T value, JsonSerializerOptions options)
        {
            writer.WriteStringValue(value.ToString());
        }
    }
}
