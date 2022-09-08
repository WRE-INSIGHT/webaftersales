<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="BuildServicingTeam.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.BuildServicingTeam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Build Team</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <h3><strong>Servicing Team</strong></h3>
    </div>
    <div>
        <div class="row">
            <div class="col-sm-6">
                <span>Search</span>
                <asp:TextBox ID="tboxSearch" CssClass="form-control" runat="server"></asp:TextBox>
                <div class="input-group">
                    <div class="input-group-btn">
                        <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server">search</asp:LinkButton>
                    </div>
                </div>
                <br />
                <asp:GridView ID="GridView1" runat="server">
                    <Columns>

                    </Columns>
                </asp:GridView>
            </div>
            <div class="col-sm-6">
            </div>
        </div>
    </div>
</asp:Content>
