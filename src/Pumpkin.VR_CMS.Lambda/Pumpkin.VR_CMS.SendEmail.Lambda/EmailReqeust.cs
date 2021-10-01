namespace Pumpkin.VR_CMS.SendEmail.Lambda
{
    public class EmailReqeust
    {
        public string From { get; set; }

        public string To { get; set; }

        public string Subject { get; set; }


        public string Content { get; set; }
    }
}
