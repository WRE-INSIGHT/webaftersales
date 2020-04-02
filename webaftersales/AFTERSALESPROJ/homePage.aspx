<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="homePage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.homePage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
    <%-- <style>
        .tboxinput {
            width: 500px;
            padding: 12px;
            margin: 5px;
            margin-right: 0px;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 0px;
            box-sizing: border-box;
        }

        .btn {
            /*box-shadow: 0px 10px 30px -7px #276873;*/
            background-color: #599bb3;
            margin: 5px;
            margin-left: 0px;
            border-radius: 0px;
            display: inline-block;
            cursor: pointer;
            color: #ffffff;
            font-family: 'Segoe UI';
            font-size: 14px;
            font-weight: normal;
            padding: 11px;
            text-decoration: none;
        }

            .btn:hover {
                background: linear-gradient(to bottom, #408c99 5%, #599bb3 100%);
                background-color: #408c99;
            }

            .btn:active {
                position: relative;
                top: 1px;
            }
    </style>--%>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <div class="page-header">
        <h3>Kenneth and Mock<small> WINDOWS AND DOORS</small></h3>
    </div>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">

        <div class="input-group">
            <asp:TextBox ID="searchtbox" Height="40" CssClass="form-control" placeholder="project name" runat="server" OnTextChanged="searchtbox_TextChanged"></asp:TextBox>
            <div class="input-group-btn">
                <asp:Button ID="searcbtn" Height="40" CssClass="btn btn-primary" runat="server" Text="Find" OnClick="searcbtn_Click" />
            </div>
        </div>

        
    </div>
    <br/>
    <div class="container">
                <div>
                    <h1><small>SERVICING SCHEDULE</small></h1>
                </div>
<br />
                <asp:GridView ID="GridView1" GridLines="None" runat="server" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" ShowHeader="False" HorizontalAlign="Left" EmptyDataText="Sorry :( No Result Found.">
                    <Columns>
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:Label ID="idlbl" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="jolbl" Visible="false" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                                <asp:Label ID="teamlbl" Visible="false" runat="server" Text='<%# Bind("TEAMID") %>'></asp:Label>
                                <asp:LinkButton ID="projectlbl" CommandName="report" runat="server" Text='<%# Bind("PROJECT") %>'></asp:LinkButton>
                                <br />
                                <asp:Label ID="addresslbl" Font-Size="15px" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                                <br />
                                <asp:Label ID="datelbl" Font-Size="20px" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>
                                <asp:Label ID="colorlbl" Visible="false" runat="server" Text='<%# Bind("PROFILE_FINISH") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <EditRowStyle BorderStyle="None" BorderWidth="0px" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                    <RowStyle Font-Names="Calibri" Font-Size="18pt" Height="120px" CssClass="rowstyle" />
                </asp:GridView>
    </div>


</asp:Content>
