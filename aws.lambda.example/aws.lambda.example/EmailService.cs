using Amazon.Lambda.Core;
using Amazon.SimpleEmailV2;
using Amazon.SimpleEmailV2.Model;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace aws.lambda.example
{
    public class EmailService
    {
        public async Task SendEmail(EmailReqeust request)
        {
            var client = new AmazonSimpleEmailServiceV2Client();

            await client.SendEmailAsync(new SendEmailRequest
            {
                FromEmailAddress = request.From,
                Destination = new Destination { ToAddresses = new List<string>() { request.To } },
                Content = new EmailContent
                {
                    Simple = new Message
                    {
                        Body = new Body { Text = new Content() { Data = request.Content, Charset = "UTF-8"} },
                        Subject = new Content() { Data = request.Subject, Charset = "UTF-8" }
                    }
                }

            }, CancellationToken.None); ;
        }
    }
}
