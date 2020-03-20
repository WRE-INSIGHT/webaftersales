<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="reportPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.reportPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .tbl td {
            padding: 10px;
        }

        .Background {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .Popup {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
            /*background-color: #FFFFFF;*/
            border-width: 3px;
            border-style: solid;
            border-color: black;
            /*padding-top: 10px;
            padding-left: 10px;*/
            width: 500px;
            height: 500px;
        }

        .lbl {
            font-size: 16px;
            font-style: italic;
            font-weight: bold;
        }

        .btncancel {
            margin-top: 10px;
            background-color: transparent;
            border: none;
            float: right;
        }

        .btn {
            -moz-box-shadow: inset 0px 1px 0px 0px #45D6D6;
            -webkit-box-shadow: inset 0px 1px 0px 0px #45D6D6;
            box-shadow: inset 0px 1px 0px 0px #45D6D6;
            background-color: #2CBBBB;
            border: 1px solid #27A0A0;
            display: inline-block;
            cursor: pointer;
            color: #FFFFFF;
            font-family: 'Open Sans Condensed', sans-serif;
            font-size: 14px;
            padding: 8px 18px;
            text-decoration: none;
            text-transform: uppercase;
        }
        /*/*.form-style-8 input[type="button"]:hover,*/ */
        /*.form-style-8 input[type="submit"]:hover*/
        .btn:hover {
            background: linear-gradient(to bottom, #34CACA 5%, #30C9C9 100%);
            background-color: #34CACA;
        }

        .tboxinput {
            width: 300px;
            padding: 12px 20px;
            margin: 8px 0;
            margin-left: 10px;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .formdiv {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
         
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <asp:Label ID="lblproject" runat="server" Text="Project Name" Font-Bold="True" Font-Names="Calibri" Font-Size="25pt" ForeColor="#000066"></asp:Label>
        <br />
        <asp:Label ID="lbladdress" runat="server" Text="Address" Font-Names="Century Gothic" Font-Size="11pt" Font-Strikeout="False" ForeColor="Black"></asp:Label>
        <br />
        <asp:Label ID="lbldate" runat="server" Text="Date" Font-Names="Segoe UI" Font-Size="20pt" Font-Strikeout="False" ForeColor="#000066"></asp:Label>
        <br />

        <table class="tbl" border="1">
            <tr>
                <td>Status</td>
                <td>Job Order No.</td>
                <td>Color</td>
                <td>Assigned Team</td>
                <td>Members</td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblstatus" runat="server" Text="Status" Font-Names="Calibri" Font-Size="12pt" Font-Strikeout="False" ForeColor="#666699" Font-Bold="True"></asp:Label></td>
                <td>
                    <asp:Label ID="lbljo" runat="server" Text="Job Order No." Font-Names="Segoe UI" Font-Size="12pt" Font-Strikeout="False" ForeColor="#666699"></asp:Label></td>
                <td>
                    <asp:Label ID="lblcolor" runat="server" Text="Profile finish" Font-Names="Calibri" Font-Size="12pt" Font-Strikeout="False" ForeColor="#666699" Font-Bold="True"></asp:Label></td>
                <td>
                    <asp:Label ID="lblteamname" runat="server" Text="teamname" Font-Names="Calibri" Font-Size="12pt" Font-Strikeout="False" ForeColor="#666699" Font-Bold="True"></asp:Label></td>
                <td>
                    <asp:Label ID="lblpersonnel" runat="server" Text="personnel" Font-Names="Calibri" Font-Size="12pt" Font-Strikeout="False" ForeColor="#666699" Font-Bold="True"></asp:Label></td>

            </tr>
        </table>
    </div>
    <div>

        <div>
         
        </div>
        <div class="formdiv">

            <table>
                <tr>
                    <td colspan="2">   <asp:Button ID="btncancel" runat="server" CssClass="btncancel" Text="X" /></td>
                </tr>
                <tr>

                    <td>
                        <asp:TextBox CssClass="tboxinput" placeholder="item no" ID="tboxitemno" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>

                    <td>
                        <asp:TextBox CssClass="tboxinput" placeholder="kno" ID="tboxkno" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>

                    <td>
                        <asp:TextBox CssClass="tboxinput" placeholder="location" ID="tboxlocation" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>

                    <td>
                        <asp:DropDownList ID="dlistspecification" CssClass="tboxinput" runat="server">
                            <asp:ListItem>-</asp:ListItem>
                            <asp:ListItem>Window</asp:ListItem>
                            <asp:ListItem>Door</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="dlistspecification" ValidationGroup="validationpopup"
                            ErrorMessage="specification is required" Text="*" ForeColor="Red" InitialValue="-"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>

                    <td>
                        <asp:TextBox CssClass="tboxinput" placeholder="mobilization cost" ID="tboxmobilizationcost" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="invalid amount" Text="*"
                            ControlToValidate="tboxmobilizationcost" Type="Double" Operator="DataTypeCheck" ValidationGroup="validationpopup"
                            ForeColor="Red"></asp:CompareValidator>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <asp:Button ID="Button1" ValidationGroup="validationpopup" CssClass="btn" Width="200" runat="server" Text="add" />
        </div>
        <asp:ValidationSummary ID="validationpopup" ForeColor="Red" ValidationGroup="validationpopup" runat="server" />
        <br />
        <asp:Button ID="btnaddnewreport" CssClass="btnsubmit" runat="server" Text="Add New Item" Width="186px" />
        <br />
        <br />
        <asp:Button ID="btnimportitem" runat="server" Text="import items" />
        <br />
    </div>
</asp:Content>
