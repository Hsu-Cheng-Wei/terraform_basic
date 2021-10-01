using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace Pumpkin.VR_CMS.CloudWatch.MediaConvert.Lambda
{
    public class Request
    {
        [JsonPropertyName("version")]
        public string Version { get; set; }

        [JsonPropertyName("id")]
        public Guid Id { get; set; }

        [JsonPropertyName("detail-type")]
        public string DetailType { get; set; }

        [JsonPropertyName("source")]
        public string Source { get; set; }

        [JsonPropertyName("account")]
        public string Account { get; set; }

        [JsonPropertyName("time")]
        public DateTime Time { get; set; }

        [JsonPropertyName("region")]
        public string Region { get; set; }

        [JsonPropertyName("resources")]
        public string[] Resources { get; set; }

        [JsonPropertyName("detail")]
        public RequestDetail Detail { get; set; }
    }

    public enum StatusType
    {
        COMPLETE,
        ERROR
    }


    public class RequestDetail
    {
        [JsonPropertyName("timestamp")]
        public long TimeStamp { get; set; }

        [JsonPropertyName("accountId")]
        public string AccountId { get; set; }

        [JsonPropertyName("queue")]
        public string Queue { get; set; }

        [JsonPropertyName("jobId")]
        public string JobId { get; set; }

        [JsonPropertyName("status")]
        [JsonConverter(typeof(EnumJsonConverter<StatusType>))]
        public StatusType Status { get; set; }

        [JsonPropertyName("userMetadata")]
        public Dictionary<string, string> UserMetadata { get; set; }

        [JsonPropertyName("outputGroupDetails")]
        public OutputGroupDetail[] OutputGroupDetails { get; set; }
    }

    public class OutputGroupDetail
    {
        [JsonPropertyName("outputDetails")]
        public OutputDetail[] OutputDetails { get; set; }

        [JsonPropertyName("playlistFilePaths")]
        public string[] PlaylistFilePaths { get; set; }

        [JsonPropertyName("type")]
        public string Type { get; set; }
    }

    public class OutputDetail
    {
        [JsonPropertyName("outputFilePaths")]
        public string[] OutputFilePaths { get; set; }

        [JsonPropertyName("durationInMs")]
        public long DurationInMs { get; set; }

        [JsonPropertyName("videoDetails")]
        public VideoDetails VideoDetails { get; set; }
    }

    public class VideoDetails
    {
        [JsonPropertyName("widthInPx")]
        public int WidthInPx { get; set; }

        [JsonPropertyName("heightInPx")]
        public int HeightInPx { get; set; }
    }
}
