<%@ Page Title="" Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="FRMreporting.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/CSSreporting.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div>
        <asp:Label ID="lblproject" runat="server" Text="Project"></asp:Label>
        <br />
        <asp:Label ID="lbladdress" runat="server" Text="Address"></asp:Label>
        <br />
    </div>

    <div class="formdiv">
        <table style="width: 100%">
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="K#"></asp:Label></td>
                <td>
                    <asp:TextBox CssClass="tboxinput" ID="TextBox1" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>

                </td>
                <td rowspan="5" style="width: 65%">
                   
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label2" runat="server" Text="Item #"></asp:Label></td>
                <td>
                    <asp:TextBox CssClass="tboxinput" ID="TextBox2" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label3" runat="server" Text="Location"></asp:Label></td>
                <td>
                    <asp:TextBox CssClass="tboxinput" ID="TextBox3" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label4" runat="server" Text="Specification"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="DropDownList1" CssClass="tboxinput" runat="server">
                        <asp:ListItem Value="-1">Select Specification</asp:ListItem>
                        <asp:ListItem>Window</asp:ListItem>
                        <asp:ListItem>Door</asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label5" runat="server" Text="Mobilization cost"></asp:Label></td>
                <td>
                    <asp:TextBox CssClass="tboxinput" ID="TextBox4" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    <asp:Button CssClass="btnsubmit" ID="Button1" runat="server" Text="Button" OnClick="Button1_Click"></asp:Button>
                    <asp:Button ID="Button2" runat="server" Text="Button" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
