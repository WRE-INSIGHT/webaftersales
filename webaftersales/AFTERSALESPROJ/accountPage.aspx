<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="accountPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.accountPage" %>

<asp:content id="Content1" contentplaceholderid="head" runat="server">
     <style>
         html {
             height: 100%;
         }

         body {
             background-size: 100% 100%;
         }

         table {
             height: 100%;
         }

         .form {
             background-color: red;
             background-color: #f3f3f3;
             padding: 50px;
             height: 100%;
         }

         .tboxinput {
             width: 200px;
             padding: 12px;
             margin: 5px;
             display: inline-block;
             border: 1px solid #ccc;
             border-radius: 0px;
             box-sizing: border-box;
         }

         .btn {
             /*box-shadow: 0px 10px 30px -7px #276873;*/
             background-color: #599bb3;
             border-radius: 0px;
             display: inline-block;
             cursor: pointer;
             color: #ffffff;
             font-family: 'Segoe UI';
             font-size: 14px;
             font-weight: normal;
             padding: 5px 24px;
             text-decoration: none;
             width: 100%;
         }

             .btn:hover {
                 background: linear-gradient(to bottom, #408c99 5%, #599bb3 100%);
                 background-color: #408c99;
             }

             .btn:active {
                 position: relative;
                 top: 1px;
             }
     </style>
</asp:content>


<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
            <td colspan="2"><h1>Change Password</h1></td>
        </tr>
        <tr>
            <td>
                <asp:TextBox CssClass="tboxinput" ID="newpasswordtbox" placeholder="New password" runat="server" TextMode="Password"></asp:TextBox></td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="newpasswordtbox" 
                     ValidationGroup="val1" ErrorMessage="new password is required" ForeColor="Red">*</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td>
                <asp:TextBox CssClass="tboxinput"  ID="confirmpasswordtbox" placeholder="Confirm password" runat="server" TextMode="Password"></asp:TextBox></td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  ControlToValidate="confirmpasswordtbox"
                     ValidationGroup="val1" ErrorMessage="confirm password is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="confirmpasswordtbox" ControlToCompare="newpasswordtbox"
                     ValidationGroup="val1" ErrorMessage="password did not match" ForeColor="Red">*</asp:CompareValidator>
            </td>
        </tr>
       <tr>
           <td>
               <asp:TextBox CssClass="tboxinput"  ID="oldpasswordtbox" placeholder="Old password" runat="server" TextMode="Password"></asp:TextBox></td>
           <td>
               <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="oldpasswordtbox"
                   ValidationGroup="val1" ErrorMessage="Old password is required" ForeColor="Red">*</asp:RequiredFieldValidator></td>
       </tr>
        <tr>
            <td>
                <asp:Button  ValidationGroup="val1" CssClass="btn" ID="updatepasswordbtn" runat="server" Text="Change password" OnClick="updatepasswordbtn_Click" /></td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="val1" runat="server" ForeColor="Red" />
            </td>
        </tr>
    </table>
</asp:content>
