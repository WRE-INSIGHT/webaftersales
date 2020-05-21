<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/DAILYHEALTHPROFILE/DHPmaster.Master" CodeBehind="dhppage3.aspx.cs" Inherits="webaftersales.DAILYHEALTHPROFILE.dhppage3" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
      <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DHP page 3</title>
</asp:Content>



<asp:Content ID="content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
     <div class="well">
        <h3><strong>Page 3</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" PostBackUrl="~/DAILYHEALTHPROFILE/dhphome.aspx" runat="server">back</asp:LinkButton>
        </div>
    </div>
    <h3 class="text-info">EMPLOYEE DAILY HEALTH PROFILE</h3>
    <h4>RECORD DATE:
            <asp:Label ID="lbldate" runat="server" Text="Label"></asp:Label></h4>
    <blockquote>
        <h4>
            <table border="0">
                <tr>
                    <td class="text-muted">NAME
                    </td>
                    <td>
                        <asp:Label ID="lblname" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="text-muted">EMPLOYEE NO.
                    </td>
                    <td>
                        <asp:Label ID="lblempno" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="text-muted">BIRTHDATE
                    </td>
                    <td>
                        <asp:Label ID="lblbirthday" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="text-muted">AGE
                    </td>
                    <td>
                        <asp:Label ID="lblage" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
        </h4>
    </blockquote>
    <h3><strong class="text-info">EMPLOYEE’s ISOLATION MONITORING REPORT</strong></h3>
    <asp:GridView ID="GridView1" runat="server"></asp:GridView>
</asp:Content>
