<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="homePage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.homePage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>
        <asp:Label ID="Label1" runat="server" Text="Welcome to After Sales Web App" Font-Bold="False" Font-Italic="False" Font-Names="Century Gothic"></asp:Label></h1>
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
  
                    <div>
                        <asp:TextBox ID="searchtbox" placeholder="project name" CssClass="tboxinput" runat="server"></asp:TextBox>
                        <asp:Button ID="searcbtn" CssClass="btn" runat="server" Text="find" OnClick="searcbtn_Click" />
                    </div>
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
                        <RowStyle Font-Names="Calibri" Font-Size="18pt" Height="120px" CssClass="rowstyle" />
                    </asp:GridView>
          
    </div>

</asp:Content>
