using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.UI.WebControls;
using webaftersales.Models;

namespace webaftersales.AFTERSALESPROJ.FileBL
{
    public class File_Upload_BusinessLogic
    {
        public string[] Folder_Files(string Folder_Path)
        {
            Boolean IsExists = Directory.Exists(HttpContext.Current.Server.MapPath(Folder_Path));
            if (!IsExists)
            {
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath(Folder_Path));
            }
            string[] filepaths = Directory.GetFiles(HttpContext.Current.Server.MapPath(Folder_Path), "*.*", SearchOption.AllDirectories);

            return filepaths;
        }
        //public List<FileModel> Files_In_Model(string Folder_Path)
        //{
        //    List<FileModel> model = new List<FileModel>();
        //    var filepaths = Folder_Files(Folder_Path);
        //    foreach (string filepath in filepaths)
        //    {
        //        FileModel i = new FileModel();
        //        var myPath = filepath.Replace("Uploads", "{");
        //        var myPathRevised = @"~\KMDIweb\Uploads\" + (myPath.Substring(myPath.LastIndexOf('{') + 1)).ToString().Replace(@"/", @"\");


        //        i.FileName = Path.GetFileName(filepath);
        //        i.FileExtension = Path.GetExtension(filepath);
        //        i.File_Path = myPathRevised;
        //        i.Date_Modified = File.GetLastWriteTime(filepath).ToString();
        //        if (i.FileExtension != ".db")
        //        {
        //            model.Add(i);
        //        }

        //    }
        //    return model;
        //}
        public List<FileModel> Files_In_Model_Virtual(string Folder_Path)
        {
            List<FileModel> model = new List<FileModel>();
            var filepaths = Folder_Files(Folder_Path);
            foreach (string filepath in filepaths)
            {
                FileModel i = new FileModel();
                var myPath = filepath.Replace("KMDI_FILES", "{");
                var myPathRevised = @"~\KMDI_FILES\" + (myPath.Substring(myPath.LastIndexOf('{') + 1)).ToString().Replace(@"/", @"\");


                i.FileName = Path.GetFileName(filepath);
                i.FileExtension = Path.GetExtension(filepath);
                i.File_Path = myPathRevised;
                i.Date_Modified = File.GetLastWriteTime(filepath).ToString();
                if (i.FileExtension != ".db")
                {
                    model.Add(i);
                }

            }
            return model;
        }
        public string Upload_File_Virtual_Sd(object sender, string Folder_Path, string filename)
        {
            Boolean IsExists = Directory.Exists(HttpContext.Current.Server.MapPath(Folder_Path));
            if (!IsExists)
            {
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath(Folder_Path));
            }
            var _error_message = "";
            if (((FileUpload)sender).HasFile)
            {
                foreach (HttpPostedFile thefile in ((FileUpload)sender).PostedFiles)
                {
                    string fileExtension = System.IO.Path.GetExtension(thefile.FileName).ToString().ToLower();

                    //if (fileExtension == ".png" || fileExtension == ".jpeg" || fileExtension == ".jpg")
                    //{
                    double filesize = thefile.ContentLength;
                    if (filesize < 52428800)
                    {
                        thefile.SaveAs(HttpContext.Current.Server.MapPath(Folder_Path + "/" + (filename + fileExtension).Replace("#", "")));
                        _error_message = "";
                    }
                    else
                    {
                        CustomValidator err = new CustomValidator();
                        _error_message = "You can only upload files of size lesser than 50 MB, but you are uploading a file of " + Math.Round((filesize / 1048576.00), 2) + " MB";
                    }
                    //}
                    //else
                    //{
                    //    _error_message = "invalid file type";
                    //}
                }
            }
            else
            {
                _error_message = "select image file!";
            }
            return _error_message;
        }
        public string Upload_File(object sender, string Folder_Path)
        {
            Boolean IsExists = Directory.Exists(HttpContext.Current.Server.MapPath(Folder_Path));
            if (!IsExists)
            {
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath(Folder_Path));
            }
            var _error_message = "";
            if (((FileUpload)sender).HasFile)
            {
                foreach (HttpPostedFile thefile in ((FileUpload)sender).PostedFiles)
                {
                    string fileExtension = System.IO.Path.GetExtension(thefile.FileName).ToString().ToLower();

                    //if (fileExtension == ".png" || fileExtension == ".jpeg" || fileExtension == ".jpg")
                    //{
                    double filesize = thefile.ContentLength;
                    if (filesize < 52428800)
                    {
                        thefile.SaveAs(HttpContext.Current.Server.MapPath(Folder_Path + "/" + thefile.FileName.Replace("#", "")));
                        _error_message = "";
                    }
                    else
                    {
                        CustomValidator err = new CustomValidator();
                        _error_message = "You can only upload files of size lesser than 50 MB, but you are uploading a file of " + Math.Round((filesize / 1048576.00), 2) + " MB";
                    }
                    //}
                    //else
                    //{
                    //    _error_message = "invalid file type";
                    //}
                }
            }
            else
            {
                _error_message = "select image file!";
            }
            return _error_message;
        }
        public bool Remove_File_From_Server(string Folder_Path)
        {
            var fullPath = HttpContext.Current.Server.MapPath(Folder_Path);
            if (!System.IO.File.Exists(fullPath)) return false;

            try //Maybe error could happen like Access denied or Presses Already User used
            {
                System.IO.File.Delete(fullPath);
                return true;
            }
            catch (Exception e)
            {
                //Debug.WriteLine(e.Message);
            }
            return false;
        }

    }
}