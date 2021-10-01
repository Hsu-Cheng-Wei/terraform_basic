using Amazon.Lambda.Core;
using Amazon.MediaConvert;
using Amazon.MediaConvert.Model;
using System.Collections.Generic;
using System.Threading.Tasks;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace Pumpkin.VR_CMS.MediaConvert.Lambda
{
    public class Function
    {
        public async Task<Response> Handler(Request request)
        {
            var client = new AmazonMediaConvertClient(new AmazonMediaConvertConfig
            {
                ServiceURL = $@"https://1muozxeta.mediaconvert.{request.Region}.amazonaws.com"
            });

            var response = await client.CreateJobAsync(new CreateJobRequest
            {
                Role = request.Role,

                Settings = new JobSettings
                {
                    Inputs = new List<Input>
                    {
                        new Input
                        {
                            AudioSelectors = new Dictionary<string, AudioSelector>
                            {
                                {"Audio Selector 1", new AudioSelector
                                {
                                    DefaultSelection = "Default"
                                } }
                            },
                            TimecodeSource = InputTimecodeSource.ZEROBASED,
                            FileInput = request.InputPath,
                        }
                    },
                    OutputGroups = new List<OutputGroup>
                    {
                        new OutputGroup
                        {
                            CustomName = request.Name,
                            Name = "Apple HLS",
                            OutputGroupSettings = new OutputGroupSettings
                            {
                                Type = OutputGroupType.HLS_GROUP_SETTINGS,
                                HlsGroupSettings = new HlsGroupSettings
                                {
                                    MinSegmentLength = 0,
                                    SegmentLength = 10,
                                    Destination = request.OutputPath,
                                }
                            },
                            Outputs = new List<Output>()
                            {
                                new Output
                                {
                                    ContainerSettings = new ContainerSettings
                                    {
                                        Container = "M3U8",
                                    },
                                    VideoDescription = new VideoDescription
                                    {
                                        CodecSettings = new VideoCodecSettings
                                        {
                                            Codec = VideoCodec.H_264,
                                            H264Settings = new H264Settings
                                            {
                                                MaxBitrate = 5000000,
                                                RateControlMode = H264RateControlMode.QVBR,
                                                SceneChangeDetect = H264SceneChangeDetect.TRANSITION_DETECTION,
                                            }
                                        }
                                    },
                                    AudioDescriptions = new List<AudioDescription>
                                    {
                                        new AudioDescription
                                        {
                                            CodecSettings = new AudioCodecSettings
                                            {
                                                Codec = AudioCodec.AAC,
                                                AacSettings = new AacSettings
                                                {
                                                    Bitrate = 96000,
                                                    CodingMode = AacCodingMode.CODING_MODE_2_0,
                                                    SampleRate = 48000
                                                }
                                            }
                                        }
                                    },
                                    NameModifier = request.Name
                                }
                            }
                        }
                    }
                }
            });

            return new Response
            {
                JobId = response.Job.Id
            };
        }
    }

    public class Request
    {
        public string Region { get; set; }

        public string Role { get; set; }

        public string Name { get; set; }

        public string InputPath { get; set; }

        public string OutputPath { get; set; }
    }

    public class Response
    {
        public string JobId { get; set; }
    }
}
