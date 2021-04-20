--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- Name: employee; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employee (
    id bigint NOT NULL,
    user_id bigint NOT NULL
);


--
-- Name: employee_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.employee_id_seq OWNED BY public.employee.id;


--
-- Name: organization; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organization (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    created_at timestamp without time zone,
    creator_id bigint NOT NULL
);


--
-- Name: organization_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organization_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organization_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organization_id_seq OWNED BY public.organization.id;


--
-- Name: request; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.request (
    id bigint NOT NULL,
    title character varying NOT NULL,
    request_type_id integer NOT NULL,
    request_sender bigint NOT NULL,
    description character varying,
    created_at timestamp without time zone,
    request_receiver bigint,
    requested_organization_id bigint,
    request_result boolean
);


--
-- Name: request_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.request_id_seq OWNED BY public.request.id;


--
-- Name: request_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.request_type (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying
);


--
-- Name: request_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.request_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: request_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.request_type_id_seq OWNED BY public.request_type.id;


--
-- Name: staff; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.staff (
    id bigint NOT NULL,
    employee_id bigint NOT NULL,
    organization_id bigint NOT NULL,
    request_id bigint NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp without time zone,
    staff_type character varying NOT NULL
);


--
-- Name: staff_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.staff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;


--
-- Name: task; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task (
    id bigint NOT NULL,
    title character varying NOT NULL,
    description character varying,
    creator_id bigint NOT NULL,
    operator_id bigint NOT NULL,
    is_done boolean,
    done_time timestamp without time zone,
    deadline timestamp without time zone NOT NULL,
    created_at timestamp without time zone
);


--
-- Name: task_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.task_id_seq OWNED BY public.task.id;


--
-- Name: token_blacklist_blacklistedtoken; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.token_blacklist_blacklistedtoken (
    id integer NOT NULL,
    blacklisted_at timestamp with time zone NOT NULL,
    token_id integer NOT NULL
);


--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.token_blacklist_blacklistedtoken_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.token_blacklist_blacklistedtoken_id_seq OWNED BY public.token_blacklist_blacklistedtoken.id;


--
-- Name: token_blacklist_outstandingtoken; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.token_blacklist_outstandingtoken (
    id integer NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone,
    expires_at timestamp with time zone NOT NULL,
    user_id integer,
    jti character varying(255) NOT NULL
);


--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.token_blacklist_outstandingtoken_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.token_blacklist_outstandingtoken_id_seq OWNED BY public.token_blacklist_outstandingtoken.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: employee id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employee ALTER COLUMN id SET DEFAULT nextval('public.employee_id_seq'::regclass);


--
-- Name: organization id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization ALTER COLUMN id SET DEFAULT nextval('public.organization_id_seq'::regclass);


--
-- Name: request id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request ALTER COLUMN id SET DEFAULT nextval('public.request_id_seq'::regclass);


--
-- Name: request_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request_type ALTER COLUMN id SET DEFAULT nextval('public.request_type_id_seq'::regclass);


--
-- Name: staff id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);


--
-- Name: task id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task ALTER COLUMN id SET DEFAULT nextval('public.task_id_seq'::regclass);


--
-- Name: token_blacklist_blacklistedtoken id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken ALTER COLUMN id SET DEFAULT nextval('public.token_blacklist_blacklistedtoken_id_seq'::regclass);


--
-- Name: token_blacklist_outstandingtoken id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken ALTER COLUMN id SET DEFAULT nextval('public.token_blacklist_outstandingtoken_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can view permission	1	view_permission
5	Can add group	2	add_group
6	Can change group	2	change_group
7	Can delete group	2	delete_group
8	Can view group	2	view_group
9	Can add user	3	add_user
10	Can change user	3	change_user
11	Can delete user	3	delete_user
12	Can view user	3	view_user
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add user type	5	add_usertype
18	Can change user type	5	change_usertype
19	Can delete user type	5	delete_usertype
20	Can view user type	5	view_usertype
21	Can add organization	6	add_organization
22	Can change organization	6	change_organization
23	Can delete organization	6	delete_organization
24	Can view organization	6	view_organization
25	Can add my user	7	add_myuser
26	Can change my user	7	change_myuser
27	Can delete my user	7	delete_myuser
28	Can view my user	7	view_myuser
29	Can add request type	8	add_requesttype
30	Can change request type	8	change_requesttype
31	Can delete request type	8	delete_requesttype
32	Can view request type	8	view_requesttype
33	Can add request	9	add_request
34	Can change request	9	change_request
35	Can delete request	9	delete_request
36	Can view request	9	view_request
37	Can add response	10	add_response
38	Can change response	10	change_response
39	Can delete response	10	delete_response
40	Can view response	10	view_response
41	Can add task	11	add_task
42	Can change task	11	change_task
43	Can delete task	11	delete_task
44	Can view task	11	view_task
45	Can add log entry	12	add_logentry
46	Can change log entry	12	change_logentry
47	Can delete log entry	12	delete_logentry
48	Can view log entry	12	view_logentry
49	Can add session	13	add_session
50	Can change session	13	change_session
51	Can delete session	13	delete_session
52	Can view session	13	view_session
53	Can add blacklisted token	14	add_blacklistedtoken
54	Can change blacklisted token	14	change_blacklistedtoken
55	Can delete blacklisted token	14	delete_blacklistedtoken
56	Can view blacklisted token	14	view_blacklistedtoken
57	Can add outstanding token	15	add_outstandingtoken
58	Can change outstanding token	15	change_outstandingtoken
59	Can delete outstanding token	15	delete_outstandingtoken
60	Can view outstanding token	15	view_outstandingtoken
61	Can add admin	16	add_admin
62	Can change admin	16	change_admin
63	Can delete admin	16	delete_admin
64	Can view admin	16	view_admin
65	Can add employee	17	add_employee
66	Can change employee	17	change_employee
67	Can delete employee	17	delete_employee
68	Can view employee	17	view_employee
69	Can add staff	18	add_staff
70	Can change staff	18	change_staff
71	Can delete staff	18	delete_staff
72	Can view staff	18	view_staff
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
21	pbkdf2_sha256$216000$4K1XlTElrQKN$dizaOhB6noh5T2acF7urotxjijNfHGWVtFU/ZNvotck=	\N	t	fhdi	Faranak	Heydari		t	t	2021-04-18 22:19:47.509382+04:30
23	pbkdf2_sha256$216000$OKBUQem3l3cC$0xRgpzHJ8wGS7aL4qF0jlNth1qN1xXdfrAvS35a83w0=	\N	t	f_1997				t	t	2021-04-19 16:37:31.898195+04:30
24	pbkdf2_sha256$216000$NFm5CQcQSSCT$WfJJGdyYHpSh+eUCgrnbf1rAYZ+TAOryc/rHRiq80Ck=	\N	t	l_2883				t	t	2021-04-19 16:37:49.663245+04:30
25	pbkdf2_sha256$216000$SFOQ1bWn8QP7$dg5TodtQLyTKUmpw8PXTX3870eL1yd9RfOesVC47Jy8=	\N	t	ali28991				t	t	2021-04-19 16:38:07.190953+04:30
26	pbkdf2_sha256$216000$Jeuks5Ls9AeP$JdmvIXzBfvjoj8vD4w5Y8Oz5rCuqydeYez0Gq2+A2S8=	\N	f	m_bagheri	mateen	bagheri		f	t	2021-04-19 16:41:13.249419+04:30
27	pbkdf2_sha256$216000$1rieKj2vIGcR$eSJ2Kjyzvt0L3BTNErudM1M1GYxXRl6bK1qIRd6Qsl4=	\N	f	faranak	Faranak	Heydari		f	t	2021-04-19 16:41:36.387407+04:30
30	pbkdf2_sha256$216000$2t6Oj6gRrk8W$UHfRMjUNv4vZpA6/k1h8wHIEfakg/nEBXEKR97sKS7U=	\N	f	s_s	Soroush	Prbdi		f	t	2021-04-19 16:43:59.329724+04:30
28	pbkdf2_sha256$216000$5GlWvWG2rjaA$qkpgYGst9622LIrV72UjLLi59sxH68QcN766UJVknLE=	\N	f	ali2021	Ali	Heydari		f	t	2021-04-19 16:42:12.572111+04:30
29	pbkdf2_sha256$216000$pNrPggtprEHD$lOftbtvB2CKLAhIxRRuw/uv65O6ziU7H8+s67wiQ0fA=	\N	f	ftm_m	Fatemeh	Mousavi		f	t	2021-04-19 16:42:46.812357+04:30
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	auth	permission
2	auth	group
3	auth	user
4	contenttypes	contenttype
5	core	usertype
6	core	organization
7	core	myuser
8	core	requesttype
9	core	request
10	core	response
11	core	task
12	admin	logentry
13	sessions	session
14	token_blacklist	blacklistedtoken
15	token_blacklist	outstandingtoken
16	core	admin
17	core	employee
18	core	staff
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-04-16 17:33:32.822363+04:30
2	auth	0001_initial	2021-04-16 17:33:33.136184+04:30
3	contenttypes	0002_remove_content_type_name	2021-04-16 17:33:33.858771+04:30
4	auth	0002_alter_permission_name_max_length	2021-04-16 17:33:33.872763+04:30
5	auth	0003_alter_user_email_max_length	2021-04-16 17:33:33.886755+04:30
6	auth	0004_alter_user_username_opts	2021-04-16 17:33:33.898748+04:30
7	auth	0005_alter_user_last_login_null	2021-04-16 17:33:33.913739+04:30
8	auth	0006_require_contenttypes_0002	2021-04-16 17:33:33.916738+04:30
9	auth	0007_alter_validators_add_error_messages	2021-04-16 17:33:33.931731+04:30
10	auth	0008_alter_user_username_max_length	2021-04-16 17:33:34.001689+04:30
11	auth	0009_alter_user_last_name_max_length	2021-04-16 17:33:34.013682+04:30
12	auth	0010_alter_group_name_max_length	2021-04-16 17:33:34.024677+04:30
13	auth	0011_update_proxy_permissions	2021-04-16 17:33:34.043665+04:30
14	auth	0012_alter_user_first_name_max_length	2021-04-16 17:33:34.054659+04:30
15	admin	0001_initial	2021-04-16 17:33:38.454234+04:30
16	admin	0002_logentry_remove_auto_add	2021-04-16 17:33:38.667783+04:30
17	admin	0003_logentry_add_action_flag_choices	2021-04-16 17:33:38.686772+04:30
18	sessions	0001_initial	2021-04-16 17:33:38.762819+04:30
19	token_blacklist	0001_initial	2021-04-16 17:33:39.204747+04:30
20	token_blacklist	0002_outstandingtoken_jti_hex	2021-04-16 17:33:39.416045+04:30
21	token_blacklist	0003_auto_20171017_2007	2021-04-16 17:33:39.448028+04:30
22	token_blacklist	0004_auto_20171017_2013	2021-04-16 17:33:39.592314+04:30
23	token_blacklist	0005_remove_outstandingtoken_jti	2021-04-16 17:33:39.649441+04:30
24	token_blacklist	0006_auto_20171017_2113	2021-04-16 17:33:39.664433+04:30
25	token_blacklist	0007_auto_20171017_2214	2021-04-16 17:33:40.280715+04:30
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.employee (id, user_id) FROM stdin;
2	26
3	27
4	28
5	29
6	30
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.organization (id, name, description, created_at, creator_id) FROM stdin;
1	wize analytics	\N	\N	21
2	some_org	\N	\N	25
3	other_org	\N	\N	24
4	new_org	just a test org	2021-04-20 19:57:03.193499	24
\.


--
-- Data for Name: request; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.request (id, title, request_type_id, request_sender, description, created_at, request_receiver, requested_organization_id, request_result) FROM stdin;
5	join_as_manager	2	2		2021-04-19 17:02:41.233004	21	1	t
6	join_as_manager	2	3		2021-04-19 17:02:41.233004	21	1	t
7	join_as_manager	2	4		2021-04-19 17:02:41.233004	21	1	t
8	join_as_employee	1	5		2021-04-19 17:02:41.233004	1	1	t
9	join_as_employee	1	6		2021-04-19 17:02:41.233004	1	1	t
10	promotion	3	5		2021-04-20 00:09:10.009067	21	\N	f
\.


--
-- Data for Name: request_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.request_type (id, name, description) FROM stdin;
1	join_employee	request to join an organization as an employee, the request will be send to the organization's manager.\nrequest_sender= employee\nrequest_receiver= org manager
2	join_manager	request to join an organization as a manager, the request will be send to admin\nrequest_sender= employee\nrequest_receiver= admin
3	promotion_employee_manager	request to get a promotion in organization to be a manager, the request will be send to the admin.\nrequest_sender= org employee\nrequest_receiver= admin
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.staff (id, employee_id, organization_id, request_id, is_active, created_at, staff_type) FROM stdin;
1	2	1	5	t	2021-04-19 23:47:53.172986	manager
2	3	1	6	t	2021-04-19 23:47:53.172986	manager
3	4	1	7	t	2021-04-19 23:47:53.172986	manager
4	5	1	8	t	2021-04-20 00:03:08.228617	employee
5	6	1	9	t	2021-04-20 00:03:08.228617	employee
\.


--
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.task (id, title, description, creator_id, operator_id, is_done, done_time, deadline, created_at) FROM stdin;
2	design db		1	4	f	\N	2021-04-30 12:00:00	2021-04-20 13:20:46.327712
3	create db	create tables and stuff	1	4	f	\N	2021-04-25 14:00:00	2021-04-20 13:29:52.804588
4	req apis	done with req apis	1	5	f	\N	2021-04-21 17:00:00	2021-04-20 15:34:51.221751
\.


--
-- Data for Name: token_blacklist_blacklistedtoken; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.token_blacklist_blacklistedtoken (id, blacklisted_at, token_id) FROM stdin;
\.


--
-- Data for Name: token_blacklist_outstandingtoken; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.token_blacklist_outstandingtoken (id, token, created_at, expires_at, user_id, jti) FROM stdin;
5	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTA5NDY4NSwianRpIjoiNzZmMjc1NDEwOTU1NDM4OWIxOTY0NTIzZGQ1ZWU2NzkiLCJ1c2VyX2lkIjoyNn0.-FIhqraPUcR_AmJ_MNoyj9SdExw1FSH8xPH_VXfoGL4	2021-04-19 17:01:25.271004+04:30	2021-04-22 17:01:25+04:30	26	76f2754109554389b1964523dd5ee679
6	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTA5NDgzNywianRpIjoiZTJiYjljMzg5OTRjNDE3M2JiNWU0ZjM2Yjc1MzY5OGQiLCJ1c2VyX2lkIjoyN30.4d26dVghacz61hSiyru-2g-WOj-qW_lfDQK-GzmSjdQ	2021-04-19 17:03:57.651659+04:30	2021-04-22 17:03:57+04:30	27	e2bb9c38994c4173bb5e4f36b753698d
7	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTA5NDg3NywianRpIjoiOTExOWJkYzU2NTBkNDQyMjg0ZGViZTdlZWQ5OGJkODkiLCJ1c2VyX2lkIjoyOH0.NfsnVP9bl8AB0iE3D4zINu39PA_nm7kbhOeUkMwQVPM	2021-04-19 17:04:37.948897+04:30	2021-04-22 17:04:37+04:30	28	9119bdc5650d442284debe7eed98bd89
8	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTA5NTAwNywianRpIjoiNDJkMjRlOTAzNzE0NDRjOWE3MmNlMTU4NTE1ZjZiMWMiLCJ1c2VyX2lkIjoyOX0.8dYuJAKAFr7oXutdnY19yzgSGgjuTVgJNx9hvq_6j0A	2021-04-19 17:06:47.453433+04:30	2021-04-22 17:06:47+04:30	29	42d24e90371444c9a72ce158515f6b1c
9	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTA5NTA0OSwianRpIjoiYjhjNDI0ZTE2NDNjNDY1MDhmMmYwYjJkOTVkNjc1ZjQiLCJ1c2VyX2lkIjozMH0.s4kT61we4OjjKu78F2ihP13ZQK7QlgYI6S6i8o45JEE	2021-04-19 17:07:29.387913+04:30	2021-04-22 17:07:29+04:30	30	b8c424e1643c46508f2f0b2d95d675f4
10	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTEwNjEzMywianRpIjoiNmViMjlhMTA0MDJmNDFjNmEwYWM1NDAwNjk3Mjg0YWIiLCJ1c2VyX2lkIjoyMX0.dP_qkXd8SGkyuz06L-a8LEOPkNA-FrusuT4KznuHNco	2021-04-19 20:12:13.166265+04:30	2021-04-22 20:12:13+04:30	21	6eb29a10402f41c6a0ac5400697284ab
11	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTExMDA5OCwianRpIjoiMzI2MGNhMzIyMjcyNDZjYmFlOTk5Y2FmNDhiOTRiNjAiLCJ1c2VyX2lkIjoyMX0.UN3Zj3zA24x3L0qrcyTOQCB8Xtcol_wnWUKqR7ZVg-4	2021-04-19 21:18:18.921713+04:30	2021-04-22 21:18:18+04:30	21	3260ca32227246cbae999caf48b94b60
12	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTExODg0MiwianRpIjoiOWIyNjRiN2NkYTI4NGE3Nzg5YTZjMjliMzY5Mzk1YTAiLCJ1c2VyX2lkIjoyMX0.E3ugrE_7UJ4eyghFBRRNO90TmSG98YTZAcwmgA9QrY0	2021-04-19 23:44:02.233893+04:30	2021-04-22 23:44:02+04:30	21	9b264b7cda284a7789a6c29b369395a0
13	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTExOTY3NywianRpIjoiMGJlOWViMGZjZGRlNDE0NTk5ZjdiNDE5ODgyN2QxZDAiLCJ1c2VyX2lkIjoyNn0.sB6rr4jYZ9Qk7w_dhECYrjVhf1gd8xdsTbcb04MW6Ug	2021-04-19 23:57:57.133988+04:30	2021-04-22 23:57:57+04:30	26	0be9eb0fcdde414599f7b4198827d1d0
14	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTEyMzE1OCwianRpIjoiZThlZWUyZDFkMTEzNDQzMmI1YWMyYjRkN2E0YjMyZTciLCJ1c2VyX2lkIjozMH0.8c1VhAQLe185wSaxdIY4FU7xd76ZIzi04avQHFUHpIQ	2021-04-20 00:55:58.848349+04:30	2021-04-23 00:55:58+04:30	30	e8eee2d1d1134432b5ac2b4d7a4b32e7
15	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTEyMzIzMSwianRpIjoiOTc1MGVjMWJmYzZjNDA0YjllZTdkYjU5ZDNjZTAwNTIiLCJ1c2VyX2lkIjoyMX0.nQVep5LVZN4zgNST0DGuVVoyQPYlI-Y7mX9lT_2tfes	2021-04-20 00:57:11.444538+04:30	2021-04-23 00:57:11+04:30	21	9750ec1bfc6c404b9ee7db59d3ce0052
16	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTEyMzQ2NCwianRpIjoiNjU4ODMwZjZjMjk0NDRiMDgwNjM5YjM0OTVmZmU1MjIiLCJ1c2VyX2lkIjoyNn0.K2PVPKnUfiizAtiqcoyU5pG50Fbm9zAnBnWqeI7RK38	2021-04-20 01:01:04.97034+04:30	2021-04-23 01:01:04+04:30	26	658830f6c29444b080639b3495ffe522
17	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTEyMzUxNCwianRpIjoiMGNkNmFlYzY2OTk0NGM3NTk1NDcwNjc2M2Y3YjgxMTUiLCJ1c2VyX2lkIjoyMX0.OKbX0-HIrjWKLbdzqpOtD6xLo0c8mN83rOSETXFVdGM	2021-04-20 01:01:54.737593+04:30	2021-04-23 01:01:54+04:30	21	0cd6aec669944c75954706763f7b8115
18	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTE2NzM3MSwianRpIjoiYTJlOTRkMDZjY2RkNDY5ZmJjYzAzNzc2NzNlZmU3OGMiLCJ1c2VyX2lkIjoyNn0.9mzr_hQMKCPO2HLft22zR8tMvwxh9wmjmPWDgpWCQWE	2021-04-20 13:12:51.784027+04:30	2021-04-23 13:12:51+04:30	26	a2e94d06ccdd469fbcc0377673efe78c
19	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTE3MzI3NywianRpIjoiNzk5NjlmODVmZWJmNDRlMDhiNzBiNjY1ZTllYzI0YjAiLCJ1c2VyX2lkIjoyNn0.qvLAKltuYVs_4L1slDGvMbhmzQ1iVwX9C_fZACO-Nuw	2021-04-20 14:51:17.086974+04:30	2021-04-23 14:51:17+04:30	26	79969f85febf44e08b70b665e9ec24b0
20	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTE3NjE3MiwianRpIjoiOWEzYjY2NWVhNjNlNDEwYWI4NmQ2OWJhYmZjMjU3NzAiLCJ1c2VyX2lkIjozMH0.hTrGvbrEmCarT4sRn5U78F3WgHI9RmLxkjz7V4IwxOQ	2021-04-20 15:39:32.584466+04:30	2021-04-23 15:39:32+04:30	30	9a3b665ea63e410ab86d69babfc25770
21	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTE3NjIzMiwianRpIjoiYjgxMDM1ZTJjZGQxNGY3YWI0Yjg2OTA1MzIwOGI4NWMiLCJ1c2VyX2lkIjoyOX0.EA-l-BUfgEH5xZkjmiA3q6DLHFSkJ8ocWCyNO4FOxrM	2021-04-20 15:40:32.809039+04:30	2021-04-23 15:40:32+04:30	29	b81035e2cdd14f7ab4b869053208b85c
22	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTE3NjI2NCwianRpIjoiOTZjNWY0M2E0ZjYwNDczOTlkMWUwMGNhY2UyMzMzMzQiLCJ1c2VyX2lkIjoyOX0.dXdeTD2q7zgWMRzzOMBydMahc452zcf54QJ1gD39c0A	2021-04-20 15:41:04.600857+04:30	2021-04-23 15:41:04+04:30	29	96c5f43a4f6047399d1e00cace233334
23	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTE4NDYxNCwianRpIjoiODA0NmM3ZjhiMjNmNDVlZjkzYjdmMjdhNDczYjdkNTEiLCJ1c2VyX2lkIjoyNn0.IMKskuAnQsj6sXeJAH8BGmev3aomGoVenHPVkO6R5ao	2021-04-20 18:00:14.989822+04:30	2021-04-23 18:00:14+04:30	26	8046c7f8b23f45ef93b7f27a473b7d51
24	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTE4ODgwOCwianRpIjoiYTkzZWZjOTliYjdjNGY2MWFkYWRhMThiOTJkOWEzOTIiLCJ1c2VyX2lkIjoyMX0.NlF8fTdkbysPO3lTHlP8tvbqrEy4hWgtagagJaZPJGc	2021-04-20 19:10:08.144973+04:30	2021-04-23 19:10:08+04:30	21	a93efc99bb7c4f61adada18b92d9a392
25	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTE4ODgzMCwianRpIjoiNTJhNDgxYjQxNTgyNDc3Mzk4YmYzMjk2YmZjNzgyMTAiLCJ1c2VyX2lkIjoyNn0.dywveOg1YlelRapw9jB7ywkKfn-z_aaqmFndDzpULB8	2021-04-20 19:10:30.009771+04:30	2021-04-23 19:10:30+04:30	26	52a481b41582477398bf3296bfc78210
26	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTE5MTExOCwianRpIjoiZjk3ODMyYjU3NjRlNDQ0MDg0NWZlNmM5NjkzYjZjZjUiLCJ1c2VyX2lkIjoyNH0.f5PcEXGTEXW2XOsF4u8MVA3tU64iKfHo72Tnmeuz2Vw	2021-04-20 19:48:38.226848+04:30	2021-04-23 19:48:38+04:30	24	f97832b5764e4440845fe6c9693b6cf5
27	eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYxOTE5NjU5OCwianRpIjoiOWRkMzA1ODE2OGRkNGZiZWEwYTEwNDJhMWZiYmQxYWUiLCJ1c2VyX2lkIjoyNn0.-rSIFNEpMCFj9XIisg9DpidFg9QADhU0RywHj-HtwME	2021-04-20 21:19:58.174182+04:30	2021-04-23 21:19:58+04:30	26	9dd3058168dd4fbea0a1042a1fbbd1ae
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 72, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 30, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 18, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 25, true);


--
-- Name: employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.employee_id_seq', 6, true);


--
-- Name: organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.organization_id_seq', 4, true);


--
-- Name: request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.request_id_seq', 10, true);


--
-- Name: request_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.request_type_id_seq', 1, false);


--
-- Name: staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.staff_id_seq', 5, true);


--
-- Name: task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.task_id_seq', 4, true);


--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.token_blacklist_blacklistedtoken_id_seq', 2, true);


--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.token_blacklist_outstandingtoken_id_seq', 27, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- Name: request request_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request
    ADD CONSTRAINT request_pkey PRIMARY KEY (id);


--
-- Name: request_type request_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request_type
    ADD CONSTRAINT request_type_pkey PRIMARY KEY (id);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- Name: task task_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_token_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_token_id_key UNIQUE (token_id);


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq UNIQUE (jti);


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like ON public.token_blacklist_outstandingtoken USING btree (jti varchar_pattern_ops);


--
-- Name: token_blacklist_outstandingtoken_user_id_83bc629a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX token_blacklist_outstandingtoken_user_id_83bc629a ON public.token_blacklist_outstandingtoken USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: employee fk_employee_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fk_employee_auth_user FOREIGN KEY (user_id) REFERENCES public.auth_user(id);


--
-- Name: organization fk_org_admin; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT fk_org_admin FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) NOT VALID;


--
-- Name: request fk_request_organization; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request
    ADD CONSTRAINT fk_request_organization FOREIGN KEY (requested_organization_id) REFERENCES public.organization(id) NOT VALID;


--
-- Name: request fk_request_request_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request
    ADD CONSTRAINT fk_request_request_type FOREIGN KEY (request_type_id) REFERENCES public.request_type(id);


--
-- Name: staff fk_staff_employee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT fk_staff_employee FOREIGN KEY (employee_id) REFERENCES public.employee(id);


--
-- Name: staff fk_staff_organization; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT fk_staff_organization FOREIGN KEY (organization_id) REFERENCES public.organization(id);


--
-- Name: staff fk_staff_request; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT fk_staff_request FOREIGN KEY (request_id) REFERENCES public.request(id);


--
-- Name: task fk_task_creator_staff; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT fk_task_creator_staff FOREIGN KEY (creator_id) REFERENCES public.staff(id) NOT VALID;


--
-- Name: task fk_task_operator_staff; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT fk_task_operator_staff FOREIGN KEY (operator_id) REFERENCES public.staff(id) NOT VALID;


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blac_token_id_3cc7fe56_fk_token_bla; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blac_token_id_3cc7fe56_fk_token_bla FOREIGN KEY (token_id) REFERENCES public.token_blacklist_outstandingtoken(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outs_user_id_83bc629a_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outs_user_id_83bc629a_fk_auth_user FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

