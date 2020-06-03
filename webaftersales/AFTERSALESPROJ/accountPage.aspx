<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="accountPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.accountPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Change password</title>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Change password</strong></h3>
    </div>
    <div class="row">
        <div class="col-sm-6">
              <table class="table">

        <tr>
            <td>New password:
            </td>
            <td>
                <asp:TextBox CssClass="form-control" ID="newpasswordtbox" placeholder="New password" runat="server" TextMode="Password"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="newpasswordtbox"
                    ValidationGroup="val1" ErrorMessage="new password is required" ForeColor="Red">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                 Confirm password:
            </td>
            <td>
                   <asp:TextBox CssClass="form-control" ID="confirmpasswordtbox" placeholder="Confirm password" runat="server" TextMode="Password"></asp:TextBox>
            </td>
            <td>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="confirmpasswordtbox"
                    ValidationGroup="val1" ErrorMessage="confirm password is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="confirmpasswordtbox" ControlToCompare="newpasswordtbox"
                    ValidationGroup="val1" ErrorMessage="password did not match" ForeColor="Red">*</asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td>
                Old password:
            </td>
            <td>
                <asp:TextBox CssClass="form-control" ID="oldpasswordtbox" placeholder="Old password" runat="server" TextMode="Password"></asp:TextBox></td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="oldpasswordtbox"
                    ValidationGroup="val1" ErrorMessage="Old password is required" ForeColor="Red">*</asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button ValidationGroup="val1" CssClass="btn btn-primary" ID="updatepasswordbtn" runat="server" Text="submit" OnClick="updatepasswordbtn_Click" /></td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="val1" runat="server" class="alert alert-danger" />
            </td>
        </tr>
    </table>
        </div>
          <div class="col-sm-6" style="background-color:whitesmoke">
              <asp:Image ID="Image1" CssClass="img-thumbnail" Width="350" Height="250" runat="server" /><br />
                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-warning" PostBackUrl="~/AFTERSALESPROJ/reqisterSign.aspx" runat="server" OnClick="LinkButton1_Click">register my signature</asp:LinkButton>
        </div>
  
      
        </div>
</asp:Content>
