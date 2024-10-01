using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace webaftersales.Models
{
    public class FileModel
    {
        public string FileName { get; set; }
        public string FileExtension { get; set; }
        public string File_Path { get; set; }
        public string Date_Modified { get; set; }
    }
}