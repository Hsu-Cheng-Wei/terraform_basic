using Amazon.Lambda.Core;
using Newtonsoft.Json;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace Pumpkin.VR_CMS.CloudWatch.MediaConvert.Lambda
{
    public class ApiRequest
    {
        public string JobId { get; set; }

        public StatusType Status { get; set; }
    }

    public class Function
    {
        private static string BaseUrl = "http://tf-lb-20211027083636768500000002-509948876.ap-northeast-1.elb.amazonaws.com";

        private static string ApiUrl = "/api/Production/video/convert/update";

        private static string Token = "E3FB276697DC8621FB1D03C8501C5C02";

        public async Task Handler(Request request)
        {
            var client = new HttpClient();

            var api = BaseUrl + ApiUrl;

            var content = new StringContent(JsonConvert.SerializeObject(new ApiRequest
            {
                JobId = request.Detail.JobId,
                Status = request.Detail.Status
            }), Encoding.UTF8, "application/json");

            client.DefaultRequestHeaders.Add("Authorization", Token);

            await client.PutAsync(api, content);
        }
    }
}
