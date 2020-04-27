<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="contactusPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.contactusPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Contact Us</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="well">
            <h3><strong>Contact Us</strong></h3>
        </div>
    </div>
    <div class="alert alert-info">
        <p>For inquiries, comments or suggestions, please call or e-mail us through our Manila and/or Cebu contact information. We will be glad to be of service.</p>
    </div>

    <div class="container">
        <h3>MANILA SHOWROOM AND OFFICE</h3>
        <p>8 Mercury Avenue, Bagumbayan, Quezon City, Philippines 1110</p>

        <p>
            Tel. no: +632 8912-4333 | +632 8913-2545<br />
            Fax. no: +632 8912-1892<br />
            For Product Inquiries: +63 917-627-0386 or email<br />
            <a href="mailto:sales@kennethandmock.com">sales@kennethandmock.com</a>
        </p>

    </div>
    <div class="container">
        <h3>CEBU SHOWROOM AND OFFICE</h3>
        <p>
            1G Design Center of Cebu<br />
            356A A.S. Fortuna corner P. Remedio Streets, Banilad, Mandaue City, Cebu, Philippines 6014
        </p>

        <p>
            Tel. no: +6332 346-1112<br />
            Fax. no: +6332 346-1113<br />
            <a href="mailto:cebu@kennethandmock.com">cebu@kennethandmock.com</a>
        </p>

    </div>
    <div class="container">
        <h3>For After Sales Service</h3>
        <p>
        </p>
        <%-- <blockquote>--%>
        <p>
            Tel. no: +632 8912-4333<br />
            Mobile no: +63 917-815-7702 | +63 922-815-7705<br />
            <a href="mailto:aftersales@kennethandmock.com">aftersales@kennethandmock.com</a>
        </p>
        <%--  </blockquote>--%>
    </div>
    <br />
    <br />

    <div class="container">
        <footer>
            <p><a class="btn btn-default" href="https://www.kennethandmock.com/">Learn more &raquo;</a></p>
        </footer>
    </div>


</asp:Content>
