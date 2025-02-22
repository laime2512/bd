PGDMP     $    '                x            concresystem    13.1    13.1 ;   L           0    0    ENCODING    ENCODING        SET client_encoding = 'BIG5';
                      false            M           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            N           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            O           1262    18081    concresystem    DATABASE     i   CREATE DATABASE concresystem WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Mexico.1252';
    DROP DATABASE concresystem;
                postgres    false            �            1255    18082 @   calcular_cantidad(integer, character, integer, double precision)    FUNCTION     �  CREATE FUNCTION public.calcular_cantidad(p_cantidad integer, p_tipo character, p_unixcaja integer, p_unixpaquete double precision) RETURNS double precision
    LANGUAGE plpgsql
    AS $$BEGIN
	if(p_tipo = '2')then
		return cast(p_cantidad as float) / cast(p_unixcaja as float);
	end if;
	if(p_tipo = '3')then
		return cast(p_cantidad as float) / cast(p_unixcaja as float) / p_unixpaquete;
	end if;
	if(p_tipo = '1')then
		return p_cantidad;
	end if;
	RETURN -1;
END
$$;
 �   DROP FUNCTION public.calcular_cantidad(p_cantidad integer, p_tipo character, p_unixcaja integer, p_unixpaquete double precision);
       public          postgres    false            �            1255    18083    tipo_cantidad(character)    FUNCTION     9  CREATE FUNCTION public.tipo_cantidad(p_tipo character) RETURNS character varying
    LANGUAGE plpgsql
    AS $$BEGIN
	if(p_tipo = '1') then
		RETURN 'Unidades';
	end if;
		if(p_tipo = '2') then
		RETURN 'Cajas';
		end if;
		if(p_tipo = '3') then
		RETURN 'Paquetes';
		end if;
		RETURN 'not';
END
$$;
 6   DROP FUNCTION public.tipo_cantidad(p_tipo character);
       public          postgres    false            �            1259    18084    acceso_sucursal    TABLE     �   CREATE TABLE public.acceso_sucursal (
    codusu bigint NOT NULL,
    codsuc integer NOT NULL,
    fecalta timestamp without time zone NOT NULL,
    fecbaja timestamp without time zone
);
 #   DROP TABLE public.acceso_sucursal;
       public         heap    postgres    false            �            1259    18087    accesousuario    TABLE     �   CREATE TABLE public.accesousuario (
    login character varying(150) NOT NULL,
    passwd character varying(200) NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    codusu bigint NOT NULL
);
 !   DROP TABLE public.accesousuario;
       public         heap    postgres    false            P           0    0    COLUMN accesousuario.login    COMMENT     Z   COMMENT ON COLUMN public.accesousuario.login IS 'nombre del usuario o login del usuario';
          public          postgres    false    201            Q           0    0    COLUMN accesousuario.passwd    COMMENT     O   COMMENT ON COLUMN public.accesousuario.passwd IS 'clave de acceso al usuario';
          public          postgres    false    201            R           0    0    COLUMN accesousuario.estado    COMMENT     H   COMMENT ON COLUMN public.accesousuario.estado IS '1=activo, 0=anulado';
          public          postgres    false    201            S           0    0    COLUMN accesousuario.codusu    COMMENT     N   COMMENT ON COLUMN public.accesousuario.codusu IS 'referencia tabla usuarios';
          public          postgres    false    201            �            1259    18091    almacen    TABLE     }   CREATE TABLE public.almacen (
    codlugar bigint NOT NULL,
    cantidad integer NOT NULL,
    codalmacen bigint NOT NULL
);
    DROP TABLE public.almacen;
       public         heap    postgres    false            �            1259    18094    area    TABLE     �   CREATE TABLE public.area (
    codare integer NOT NULL,
    nombre character varying(100) NOT NULL,
    estado boolean NOT NULL
);
    DROP TABLE public.area;
       public         heap    postgres    false            �            1259    18097    backup    TABLE     �   CREATE TABLE public.backup (
    cod bigint NOT NULL,
    xuser character varying(250) NOT NULL,
    descripcion character varying(500) NOT NULL
);
    DROP TABLE public.backup;
       public         heap    postgres    false            �            1259    18103    caja    TABLE     i  CREATE TABLE public.caja (
    codcaja bigint NOT NULL,
    codusu bigint NOT NULL,
    fini timestamp(6) without time zone NOT NULL,
    ffin timestamp(6) without time zone,
    monini real NOT NULL,
    monfin real,
    monsistema real,
    estado smallint DEFAULT 1 NOT NULL,
    codsuc integer,
    observacion character varying(1500),
    tipo smallint
);
    DROP TABLE public.caja;
       public         heap    postgres    false            T           0    0    COLUMN caja.codcaja    COMMENT     ;   COMMENT ON COLUMN public.caja.codcaja IS 'codigo de caja';
          public          postgres    false    205            U           0    0    COLUMN caja.codusu    COMMENT     E   COMMENT ON COLUMN public.caja.codusu IS 'referencia tabal usuarios';
          public          postgres    false    205            V           0    0    COLUMN caja.fini    COMMENT     D   COMMENT ON COLUMN public.caja.fini IS 'fecha de inicio de la caja';
          public          postgres    false    205            W           0    0    COLUMN caja.ffin    COMMENT     >   COMMENT ON COLUMN public.caja.ffin IS 'fecha fin de la caja';
          public          postgres    false    205            X           0    0    COLUMN caja.monini    COMMENT     D   COMMENT ON COLUMN public.caja.monini IS 'monto inicial de la caja';
          public          postgres    false    205            Y           0    0    COLUMN caja.monfin    COMMENT     B   COMMENT ON COLUMN public.caja.monfin IS 'monto final de la caja';
          public          postgres    false    205            Z           0    0    COLUMN caja.monsistema    COMMENT     B   COMMENT ON COLUMN public.caja.monsistema IS 'monto del sistema ';
          public          postgres    false    205            [           0    0    COLUMN caja.estado    COMMENT     ?   COMMENT ON COLUMN public.caja.estado IS '1=activo, 0=anulado';
          public          postgres    false    205            \           0    0    COLUMN caja.tipo    COMMENT     @   COMMENT ON COLUMN public.caja.tipo IS '1=activo, 2=finalizado';
          public          postgres    false    205            �            1259    18110 	   categoria    TABLE     �   CREATE TABLE public.categoria (
    codcat smallint NOT NULL,
    nomcat character varying(500) NOT NULL,
    estado smallint NOT NULL
);
    DROP TABLE public.categoria;
       public         heap    postgres    false            ]           0    0    COLUMN categoria.codcat    COMMENT     D   COMMENT ON COLUMN public.categoria.codcat IS 'codigo de categoria';
          public          postgres    false    206            ^           0    0    COLUMN categoria.nomcat    COMMENT     G   COMMENT ON COLUMN public.categoria.nomcat IS 'nombre de la categoria';
          public          postgres    false    206            _           0    0    COLUMN categoria.estado    COMMENT     D   COMMENT ON COLUMN public.categoria.estado IS '1=activo, 0=anulado';
          public          postgres    false    206            �            1259    18116    cliente    TABLE     �   CREATE TABLE public.cliente (
    estado smallint DEFAULT 1 NOT NULL,
    nit character varying(15),
    direccion character varying(255),
    celular character varying(15),
    codcli bigint NOT NULL,
    razon_nit character varying(250)
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            `           0    0    COLUMN cliente.estado    COMMENT     B   COMMENT ON COLUMN public.cliente.estado IS '1=activo, 0=anulado';
          public          postgres    false    207            a           0    0    COLUMN cliente.nit    COMMENT     ;   COMMENT ON COLUMN public.cliente.nit IS 'nit del cliente';
          public          postgres    false    207            b           0    0    COLUMN cliente.direccion    COMMENT     G   COMMENT ON COLUMN public.cliente.direccion IS 'direccion del cliente';
          public          postgres    false    207            c           0    0    COLUMN cliente.celular    COMMENT     C   COMMENT ON COLUMN public.cliente.celular IS 'celular del cliente';
          public          postgres    false    207            d           0    0    COLUMN cliente.codcli    COMMENT     A   COMMENT ON COLUMN public.cliente.codcli IS 'codigo del cliente';
          public          postgres    false    207            �            1259    18123    compra    TABLE     	  CREATE TABLE public.compra (
    codcom bigint NOT NULL,
    fecha timestamp(0) without time zone NOT NULL,
    estado smallint DEFAULT 1,
    codusu bigint NOT NULL,
    codpro bigint NOT NULL,
    tiponota smallint DEFAULT 1 NOT NULL,
    total real NOT NULL,
    descuento real,
    codcaja bigint,
    coddetcaja bigint,
    num bigint NOT NULL,
    formapago integer,
    bonificacion real,
    subtotal real,
    numnota character varying(50),
    codsuc integer,
    credito boolean,
    estado_credito boolean
);
    DROP TABLE public.compra;
       public         heap    postgres    false            e           0    0    COLUMN compra.codcom    COMMENT     ?   COMMENT ON COLUMN public.compra.codcom IS 'codigo de compra ';
          public          postgres    false    208            f           0    0    COLUMN compra.fecha    COMMENT     ?   COMMENT ON COLUMN public.compra.fecha IS 'fecha de la compra';
          public          postgres    false    208            g           0    0    COLUMN compra.estado    COMMENT     A   COMMENT ON COLUMN public.compra.estado IS '1=activo, 0=anulado';
          public          postgres    false    208            h           0    0    COLUMN compra.codusu    COMMENT     G   COMMENT ON COLUMN public.compra.codusu IS 'referencia tabla usuarios';
          public          postgres    false    208            i           0    0    COLUMN compra.codpro    COMMENT     G   COMMENT ON COLUMN public.compra.codpro IS 'referencia tabla producto';
          public          postgres    false    208            j           0    0    COLUMN compra.tiponota    COMMENT     ]   COMMENT ON COLUMN public.compra.tiponota IS 'tipo de compra 1 = nota de venta y 2 =factura';
          public          postgres    false    208            k           0    0    COLUMN compra.total    COMMENT     ?   COMMENT ON COLUMN public.compra.total IS 'total de la compra';
          public          postgres    false    208            l           0    0    COLUMN compra.descuento    COMMENT     Q   COMMENT ON COLUMN public.compra.descuento IS 'descuento especiald de la compra';
          public          postgres    false    208            m           0    0    COLUMN compra.formapago    COMMENT     H   COMMENT ON COLUMN public.compra.formapago IS 'con dinero, con tarjeta';
          public          postgres    false    208            n           0    0    COLUMN compra.credito    COMMENT     D   COMMENT ON COLUMN public.compra.credito IS 'true = si, false = no';
          public          postgres    false    208            o           0    0    COLUMN compra.estado_credito    COMMENT     Z   COMMENT ON COLUMN public.compra.estado_credito IS 'true = pendiente, false = finalizado';
          public          postgres    false    208            �            1259    18128    cuenta    TABLE     �   CREATE TABLE public.cuenta (
    codcuenta integer NOT NULL,
    nombre character varying(150) NOT NULL,
    estado boolean NOT NULL,
    tipo boolean NOT NULL
);
    DROP TABLE public.cuenta;
       public         heap    postgres    false            p           0    0    COLUMN cuenta.estado    COMMENT     E   COMMENT ON COLUMN public.cuenta.estado IS 'true= debe, false=haber';
          public          postgres    false    209            �            1259    18131    detalle_margen    TABLE     �   CREATE TABLE public.detalle_margen (
    cod_margen integer NOT NULL,
    number_margin smallint NOT NULL,
    concept character varying(500) NOT NULL,
    type_margin character varying(50) NOT NULL,
    porcentaje_unidad real NOT NULL
);
 "   DROP TABLE public.detalle_margen;
       public         heap    postgres    false            q           0    0    TABLE detalle_margen    COMMENT     =   COMMENT ON TABLE public.detalle_margen IS 'Tabla de margen';
          public          postgres    false    210            �            1259    18137    detalle_salida    TABLE     �   CREATE TABLE public.detalle_salida (
    codsal bigint NOT NULL,
    codalmacen bigint NOT NULL,
    cantidad integer NOT NULL,
    fingreso date,
    fvencimiento date,
    in_out boolean DEFAULT false,
    is_response boolean
);
 "   DROP TABLE public.detalle_salida;
       public         heap    postgres    false            �            1259    18141    detallecaja    TABLE     �   CREATE TABLE public.detallecaja (
    codcaja bigint NOT NULL,
    coddetcaja bigint NOT NULL,
    monto real NOT NULL,
    fecha timestamp(6) without time zone NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    codcuenta integer
);
    DROP TABLE public.detallecaja;
       public         heap    postgres    false            r           0    0    COLUMN detallecaja.codcaja    COMMENT     I   COMMENT ON COLUMN public.detallecaja.codcaja IS 'referencia tabla caja';
          public          postgres    false    212            s           0    0    COLUMN detallecaja.coddetcaja    COMMENT     P   COMMENT ON COLUMN public.detallecaja.coddetcaja IS 'codigo de detalle de caja';
          public          postgres    false    212            t           0    0    COLUMN detallecaja.monto    COMMENT     B   COMMENT ON COLUMN public.detallecaja.monto IS 'monto de la caja';
          public          postgres    false    212            u           0    0    COLUMN detallecaja.fecha    COMMENT     B   COMMENT ON COLUMN public.detallecaja.fecha IS 'fecha de la caja';
          public          postgres    false    212            v           0    0    COLUMN detallecaja.estado    COMMENT     B   COMMENT ON COLUMN public.detallecaja.estado IS '1=debe, 0=haber';
          public          postgres    false    212            �            1259    18145    detallecompra    TABLE     �  CREATE TABLE public.detallecompra (
    codcom bigint NOT NULL,
    codpro bigint,
    cantidad smallint NOT NULL,
    precio real NOT NULL,
    subtotal real NOT NULL,
    fingreso date,
    fvencimiento date,
    codalmacen bigint,
    coddcom integer NOT NULL,
    impuestos real,
    devolucion boolean,
    descuento real,
    porcentaje_unidad real,
    porcentaje_caja real,
    porcentaje_paquete real,
    tipo_compra character(1)
);
 !   DROP TABLE public.detallecompra;
       public         heap    postgres    false            w           0    0    COLUMN detallecompra.codcom    COMMENT     Q   COMMENT ON COLUMN public.detallecompra.codcom IS 'referencia a la tabla compra';
          public          postgres    false    213            x           0    0    COLUMN detallecompra.codpro    COMMENT     S   COMMENT ON COLUMN public.detallecompra.codpro IS 'referencia a la tabla producto';
          public          postgres    false    213            y           0    0    COLUMN detallecompra.cantidad    COMMENT     K   COMMENT ON COLUMN public.detallecompra.cantidad IS 'cantidad de producto';
          public          postgres    false    213            z           0    0    COLUMN detallecompra.precio    COMMENT     G   COMMENT ON COLUMN public.detallecompra.precio IS 'precio de producto';
          public          postgres    false    213            {           0    0    COLUMN detallecompra.subtotal    COMMENT     ?   COMMENT ON COLUMN public.detallecompra.subtotal IS 'subtotal';
          public          postgres    false    213            |           0    0    COLUMN detallecompra.fingreso    COMMENT     G   COMMENT ON COLUMN public.detallecompra.fingreso IS 'fecha de ingreso';
          public          postgres    false    213            }           0    0 !   COLUMN detallecompra.fvencimiento    COMMENT     O   COMMENT ON COLUMN public.detallecompra.fvencimiento IS 'fecha de vencimiento';
          public          postgres    false    213            ~           0    0    COLUMN detallecompra.codalmacen    COMMENT     G   COMMENT ON COLUMN public.detallecompra.codalmacen IS 'codigo almacen';
          public          postgres    false    213                       0    0    COLUMN detallecompra.coddcom    COMMENT     N   COMMENT ON COLUMN public.detallecompra.coddcom IS 'codigo detalle de compra';
          public          postgres    false    213            �           0    0     COLUMN detallecompra.tipo_compra    COMMENT     v   COMMENT ON COLUMN public.detallecompra.tipo_compra IS '1=compra por unidad, 2=compra por caja, 3=compra por paquete';
          public          postgres    false    213            �            1259    18148    detallepedido    TABLE     �   CREATE TABLE public.detallepedido (
    codped bigint NOT NULL,
    codpro bigint NOT NULL,
    cantidad integer NOT NULL,
    precio real NOT NULL,
    subtotal real NOT NULL
);
 !   DROP TABLE public.detallepedido;
       public         heap    postgres    false            �            1259    18151    detallepromo    TABLE     �   CREATE TABLE public.detallepromo (
    codpromo bigint NOT NULL,
    codpro bigint NOT NULL,
    descuento_unidad real NOT NULL,
    descuento_caja real,
    descuento_paquete real
);
     DROP TABLE public.detallepromo;
       public         heap    postgres    false            �            1259    18154    detalleventa    TABLE     �   CREATE TABLE public.detalleventa (
    codpro bigint NOT NULL,
    cantidad integer NOT NULL,
    codven bigint NOT NULL,
    precio real NOT NULL,
    subtotal real,
    codalmacen bigint NOT NULL,
    tipo_venta character(1),
    codpromo bigint
);
     DROP TABLE public.detalleventa;
       public         heap    postgres    false            �           0    0    COLUMN detalleventa.codpro    COMMENT     R   COMMENT ON COLUMN public.detalleventa.codpro IS 'referencia a la tabla producto';
          public          postgres    false    216            �           0    0    COLUMN detalleventa.cantidad    COMMENT     K   COMMENT ON COLUMN public.detalleventa.cantidad IS 'cantidad del producto';
          public          postgres    false    216            �           0    0    COLUMN detalleventa.codven    COMMENT     O   COMMENT ON COLUMN public.detalleventa.codven IS 'referencia a la tabla venta';
          public          postgres    false    216            �           0    0    COLUMN detalleventa.precio    COMMENT     G   COMMENT ON COLUMN public.detalleventa.precio IS 'precio del producto';
          public          postgres    false    216            �           0    0    COLUMN detalleventa.subtotal    COMMENT     ?   COMMENT ON COLUMN public.detalleventa.subtotal IS 'subtotal ';
          public          postgres    false    216            �            1259    18157    dosificacion    TABLE     �  CREATE TABLE public.dosificacion (
    coddosificacion integer NOT NULL,
    razonsocial character varying(500) NOT NULL,
    direccion character varying(1000) NOT NULL,
    telefono character varying(200) NOT NULL,
    lugar character varying(400) NOT NULL,
    nit character varying(100) NOT NULL,
    numaut character varying(50) NOT NULL,
    actividad character varying(500) NOT NULL,
    llave character varying(500) NOT NULL,
    leyenda character varying(500) NOT NULL,
    mensaje character varying(500) NOT NULL,
    flimite date NOT NULL,
    ftramite date,
    numtramite character varying(50),
    sfc character varying(1000),
    est integer NOT NULL,
    codsuc integer,
    sigla character varying(25),
    numinifac integer,
    numfinfac integer
);
     DROP TABLE public.dosificacion;
       public         heap    postgres    false            �           0    0    COLUMN dosificacion.est    COMMENT     S   COMMENT ON COLUMN public.dosificacion.est IS '0:eliminado, 1:activo,2=finalizado';
          public          postgres    false    217            �            1259    18163    factura    TABLE     |  CREATE TABLE public.factura (
    coddosificacion integer NOT NULL,
    numfac integer NOT NULL,
    fecfac timestamp(6) without time zone NOT NULL,
    nitfac character varying(100) NOT NULL,
    codcontrol character varying(100) NOT NULL,
    estado character varying(30) NOT NULL,
    cliente_nit character varying(255),
    codven bigint,
    codcom bigint,
    total real
);
    DROP TABLE public.factura;
       public         heap    postgres    false            �           0    0    COLUMN factura.coddosificacion    COMMENT     N   COMMENT ON COLUMN public.factura.coddosificacion IS 'codigo de dosificacion';
          public          postgres    false    218            �           0    0    COLUMN factura.numfac    COMMENT     C   COMMENT ON COLUMN public.factura.numfac IS 'numero de la factura';
          public          postgres    false    218            �           0    0    COLUMN factura.fecfac    COMMENT     B   COMMENT ON COLUMN public.factura.fecfac IS 'fecha de la factura';
          public          postgres    false    218            �           0    0    COLUMN factura.nitfac    COMMENT     @   COMMENT ON COLUMN public.factura.nitfac IS 'nit de la factura';
          public          postgres    false    218            �           0    0    COLUMN factura.codcontrol    COMMENT     D   COMMENT ON COLUMN public.factura.codcontrol IS 'codigo de control';
          public          postgres    false    218            �           0    0    COLUMN factura.estado    COMMENT     B   COMMENT ON COLUMN public.factura.estado IS '1=activo, 0=anulado';
          public          postgres    false    218            �            1259    18166    laboratorio    TABLE     �   CREATE TABLE public.laboratorio (
    codlab integer NOT NULL,
    nombre character varying(250) NOT NULL,
    estado boolean DEFAULT true NOT NULL
);
    DROP TABLE public.laboratorio;
       public         heap    postgres    false            �            1259    18170    lugar    TABLE     �   CREATE TABLE public.lugar (
    codsuc integer NOT NULL,
    codpro bigint NOT NULL,
    codposicion integer NOT NULL,
    codlugar bigint NOT NULL
);
    DROP TABLE public.lugar;
       public         heap    postgres    false            �            1259    18173    margen    TABLE     �   CREATE TABLE public.margen (
    cod_margen integer NOT NULL,
    codusu bigint NOT NULL,
    date_register timestamp without time zone NOT NULL,
    observacion character varying(500) NOT NULL,
    estado boolean DEFAULT true NOT NULL
);
    DROP TABLE public.margen;
       public         heap    postgres    false            �            1259    18180    medida    TABLE     �   CREATE TABLE public.medida (
    codmed integer NOT NULL,
    nombre character varying(50) NOT NULL,
    estado boolean NOT NULL
);
    DROP TABLE public.medida;
       public         heap    postgres    false            �            1259    18183    menu    TABLE     �   CREATE TABLE public.menu (
    codm integer NOT NULL,
    nombre character varying(40) NOT NULL,
    estado smallint DEFAULT 1 NOT NULL
);
    DROP TABLE public.menu;
       public         heap    postgres    false            �           0    0    COLUMN menu.codm    COMMENT     9   COMMENT ON COLUMN public.menu.codm IS 'codigo del menu';
          public          postgres    false    223            �           0    0    COLUMN menu.nombre    COMMENT     ;   COMMENT ON COLUMN public.menu.nombre IS 'nombre del menu';
          public          postgres    false    223            �           0    0    COLUMN menu.estado    COMMENT     ?   COMMENT ON COLUMN public.menu.estado IS '1=activo, 0=anulado';
          public          postgres    false    223            �            1259    18187    mepro    TABLE     T   CREATE TABLE public.mepro (
    codm integer NOT NULL,
    codp integer NOT NULL
);
    DROP TABLE public.mepro;
       public         heap    postgres    false            �           0    0    COLUMN mepro.codm    COMMENT     @   COMMENT ON COLUMN public.mepro.codm IS 'referencia tabla menu';
          public          postgres    false    224            �           0    0    COLUMN mepro.codp    COMMENT     D   COMMENT ON COLUMN public.mepro.codp IS 'referencia tabla procesos';
          public          postgres    false    224            �            1259    18190    mueble    TABLE     �   CREATE TABLE public.mueble (
    codmueble integer NOT NULL,
    nombre character varying(255) NOT NULL,
    estado smallint DEFAULT 1,
    codtimu integer
);
    DROP TABLE public.mueble;
       public         heap    postgres    false            �           0    0    COLUMN mueble.codmueble    COMMENT     A   COMMENT ON COLUMN public.mueble.codmueble IS 'codigo de mueble';
          public          postgres    false    225            �           0    0    COLUMN mueble.nombre    COMMENT     >   COMMENT ON COLUMN public.mueble.nombre IS 'nombre de mueble';
          public          postgres    false    225            �            1259    18194    pagocredito    TABLE     �   CREATE TABLE public.pagocredito (
    codcom bigint NOT NULL,
    fecha date NOT NULL,
    fecreg timestamp(6) without time zone NOT NULL,
    monto real NOT NULL,
    codusu bigint NOT NULL,
    observacion character varying(500)
);
    DROP TABLE public.pagocredito;
       public         heap    postgres    false            �            1259    18200    pedido    TABLE     �  CREATE TABLE public.pedido (
    codped bigint NOT NULL,
    fecha timestamp(6) without time zone NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    codusu bigint NOT NULL,
    celular character varying(15) NOT NULL,
    direccion character varying(255),
    observacion character varying(500),
    fentrega timestamp(6) without time zone,
    coddelivery integer,
    nit character varying(25),
    razon_nit character varying(250),
    codven bigint,
    codsuc integer
);
    DROP TABLE public.pedido;
       public         heap    postgres    false            �            1259    18207    posicion    TABLE     �   CREATE TABLE public.posicion (
    codposicion integer NOT NULL,
    nombre character varying(255) NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    codmueble integer
);
    DROP TABLE public.posicion;
       public         heap    postgres    false            �           0    0    COLUMN posicion.codposicion    COMMENT     H   COMMENT ON COLUMN public.posicion.codposicion IS 'codigo de posicion ';
          public          postgres    false    228            �           0    0    COLUMN posicion.nombre    COMMENT     B   COMMENT ON COLUMN public.posicion.nombre IS 'nombre de posicion';
          public          postgres    false    228            �           0    0    COLUMN posicion.estado    COMMENT     C   COMMENT ON COLUMN public.posicion.estado IS '1=activo, 0=anulado';
          public          postgres    false    228            �            1259    18211    presentacion    TABLE     �   CREATE TABLE public.presentacion (
    codpre integer NOT NULL,
    nombre character varying NOT NULL,
    estado boolean NOT NULL
);
     DROP TABLE public.presentacion;
       public         heap    postgres    false            �            1259    18217    proceso    TABLE     �   CREATE TABLE public.proceso (
    codp integer NOT NULL,
    nombre character varying(40) NOT NULL,
    enlace character varying(60) NOT NULL,
    estado smallint DEFAULT 1 NOT NULL
);
    DROP TABLE public.proceso;
       public         heap    postgres    false            �           0    0    COLUMN proceso.codp    COMMENT     ?   COMMENT ON COLUMN public.proceso.codp IS 'codigo de procesos';
          public          postgres    false    230            �           0    0    COLUMN proceso.nombre    COMMENT     A   COMMENT ON COLUMN public.proceso.nombre IS 'nombre del proceso';
          public          postgres    false    230            �           0    0    COLUMN proceso.enlace    COMMENT     H   COMMENT ON COLUMN public.proceso.enlace IS 'link o enlace del proceso';
          public          postgres    false    230            �           0    0    COLUMN proceso.estado    COMMENT     B   COMMENT ON COLUMN public.proceso.estado IS '1=activo, 0=anulado';
          public          postgres    false    230            �            1259    18221    producto    TABLE     �  CREATE TABLE public.producto (
    codpro bigint NOT NULL,
    nombre character varying(150),
    estado smallint DEFAULT 1,
    foto character varying(40),
    codtip smallint,
    generico character varying(255),
    codigobarra character varying(30),
    codlab integer,
    concentracion character varying(25),
    codmed integer,
    codare integer,
    pc_unit real,
    pv_unit real,
    porcentaje_unidad real,
    codpre integer,
    controlado boolean DEFAULT false,
    inventario_minimo_unidad real,
    pareto character varying(25),
    unixcaja integer DEFAULT 0,
    pv_caja real,
    pv_descuento_caja real,
    pc_caja real,
    unixpaquete real,
    uni_en_paquete real,
    inventario_minimo_caja real,
    inventario_minimo_paquete real,
    pc_paquete real,
    pv_paquete real,
    porcentaje_caja real,
    porcentaje_paquete real,
    tipo_compra character(1),
    pv_descuento_paquete real,
    presentacion_unidad character varying(25),
    presentacion_caja character varying(25),
    presentacion_paquete character varying(25),
    margen character(1),
    porcentaje_descuento_caja real,
    porcentaje_descuento_paquete real
);
    DROP TABLE public.producto;
       public         heap    postgres    false            �           0    0    COLUMN producto.codpro    COMMENT     B   COMMENT ON COLUMN public.producto.codpro IS 'codigo de producto';
          public          postgres    false    231            �           0    0    COLUMN producto.nombre    COMMENT     B   COMMENT ON COLUMN public.producto.nombre IS 'nombre de producto';
          public          postgres    false    231            �           0    0    COLUMN producto.estado    COMMENT     C   COMMENT ON COLUMN public.producto.estado IS '1=activo, 0=anulado';
          public          postgres    false    231            �           0    0    COLUMN producto.foto    COMMENT     ?   COMMENT ON COLUMN public.producto.foto IS 'foto del producto';
          public          postgres    false    231            �           0    0    COLUMN producto.codtip    COMMENT     K   COMMENT ON COLUMN public.producto.codtip IS 'codigo del tipo de producto';
          public          postgres    false    231            �           0    0    COLUMN producto.generico    COMMENT     J   COMMENT ON COLUMN public.producto.generico IS 'composicion del producto';
          public          postgres    false    231            �           0    0    COLUMN producto.codigobarra    COMMENT     Q   COMMENT ON COLUMN public.producto.codigobarra IS 'codigo de barra del producto';
          public          postgres    false    231            �           0    0    COLUMN producto.codlab    COMMENT     E   COMMENT ON COLUMN public.producto.codlab IS 'codigo de laboratorio';
          public          postgres    false    231            �            1259    18230    producto_nuevo    TABLE     �   CREATE TABLE public.producto_nuevo (
    cod_pro_nuevo bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion character varying(300),
    estado boolean DEFAULT true NOT NULL,
    codusu bigint NOT NULL
);
 "   DROP TABLE public.producto_nuevo;
       public         heap    postgres    false            �            1259    18234 	   promocion    TABLE     :  CREATE TABLE public.promocion (
    codpromo bigint NOT NULL,
    fcreacion date NOT NULL,
    fini date NOT NULL,
    ffin date NOT NULL,
    titulo character varying(100) NOT NULL,
    descripcion character varying(500),
    codusu bigint NOT NULL,
    estpromo boolean NOT NULL,
    gestion integer NOT NULL
);
    DROP TABLE public.promocion;
       public         heap    postgres    false            �            1259    18240 	   proveedor    TABLE       CREATE TABLE public.proveedor (
    codproveedor bigint NOT NULL,
    nombre character varying(40) NOT NULL,
    nit integer NOT NULL,
    direccion character varying(40) NOT NULL,
    telefono character varying(20) NOT NULL,
    estado smallint DEFAULT 1
);
    DROP TABLE public.proveedor;
       public         heap    postgres    false            �           0    0    COLUMN proveedor.codproveedor    COMMENT     J   COMMENT ON COLUMN public.proveedor.codproveedor IS 'codigo de proveedor';
          public          postgres    false    234            �           0    0    COLUMN proveedor.nombre    COMMENT     D   COMMENT ON COLUMN public.proveedor.nombre IS 'nombre de proveedor';
          public          postgres    false    234            �           0    0    COLUMN proveedor.nit    COMMENT     >   COMMENT ON COLUMN public.proveedor.nit IS 'nit de proveedor';
          public          postgres    false    234            �           0    0    COLUMN proveedor.direccion    COMMENT     J   COMMENT ON COLUMN public.proveedor.direccion IS 'direccion de proveedor';
          public          postgres    false    234            �           0    0    COLUMN proveedor.telefono    COMMENT     H   COMMENT ON COLUMN public.proveedor.telefono IS 'telefono de proveedor';
          public          postgres    false    234            �           0    0    COLUMN proveedor.estado    COMMENT     D   COMMENT ON COLUMN public.proveedor.estado IS '1=activo, 0=anulado';
          public          postgres    false    234            �            1259    18244    rol    TABLE     �   CREATE TABLE public.rol (
    codr integer NOT NULL,
    nombre character varying(40) NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    acceso_venta boolean DEFAULT false
);
    DROP TABLE public.rol;
       public         heap    postgres    false            �           0    0    COLUMN rol.codr    COMMENT     7   COMMENT ON COLUMN public.rol.codr IS 'codigo del rol';
          public          postgres    false    235            �           0    0    COLUMN rol.nombre    COMMENT     9   COMMENT ON COLUMN public.rol.nombre IS 'nombre del rol';
          public          postgres    false    235            �           0    0    COLUMN rol.estado    COMMENT     >   COMMENT ON COLUMN public.rol.estado IS '1=activo, 0=anulado';
          public          postgres    false    235            �           0    0    COLUMN rol.acceso_venta    COMMENT     g   COMMENT ON COLUMN public.rol.acceso_venta IS 'Ventas: true=acceso completo, false=acceso restringido';
          public          postgres    false    235            �            1259    18249    rolme    TABLE     T   CREATE TABLE public.rolme (
    codr integer NOT NULL,
    codm integer NOT NULL
);
    DROP TABLE public.rolme;
       public         heap    postgres    false            �           0    0    COLUMN rolme.codr    COMMENT     A   COMMENT ON COLUMN public.rolme.codr IS 'referencia tabla roles';
          public          postgres    false    236            �           0    0    COLUMN rolme.codm    COMMENT     @   COMMENT ON COLUMN public.rolme.codm IS 'referencia tabla menu';
          public          postgres    false    236            �            1259    18252    rolusu    TABLE     e   CREATE TABLE public.rolusu (
    codr integer NOT NULL,
    login character varying(150) NOT NULL
);
    DROP TABLE public.rolusu;
       public         heap    postgres    false            �           0    0    COLUMN rolusu.codr    COMMENT     B   COMMENT ON COLUMN public.rolusu.codr IS 'referencia tabla roles';
          public          postgres    false    237            �           0    0    COLUMN rolusu.login    COMMENT     I   COMMENT ON COLUMN public.rolusu.login IS 'refencia tabla accesousuario';
          public          postgres    false    237            �            1259    18255    salida    TABLE     |  CREATE TABLE public.salida (
    codsal bigint NOT NULL,
    fsalida date,
    codusu bigint,
    tipo smallint,
    descripcion character varying(500),
    estado character varying(1),
    est boolean,
    numero bigint NOT NULL,
    suc_origen integer,
    suc_destino integer,
    in_out boolean,
    solucion smallint,
    monto real,
    conclusion character varying(500)
);
    DROP TABLE public.salida;
       public         heap    postgres    false            �           0    0    COLUMN salida.tipo    COMMENT     J  COMMENT ON COLUMN public.salida.tipo IS '1= Productos en mal estado,
2= Salida a otra farmacia egreso,
3=Medicamentos vencidos,
4= Perdida de medicamentos,
5= Uso de farmacia,
6= Disminucion de medicamento por usuario
7=Aumento de medicamento por usuario
8=Entrada de medicamento
9=salida
10=entrada de otra farmacia
';
          public          postgres    false    238            �           0    0    COLUMN salida.estado    COMMENT     R   COMMENT ON COLUMN public.salida.estado IS 'p=pendiente
a=aceptado
r=rechazado';
          public          postgres    false    238            �           0    0    COLUMN salida.in_out    COMMENT     J   COMMENT ON COLUMN public.salida.in_out IS 'true= ingreso, false= salida';
          public          postgres    false    238            �           0    0    COLUMN salida.solucion    COMMENT     3   COMMENT ON COLUMN public.salida.solucion IS '1= ';
          public          postgres    false    238            �            1259    18261    sucursal    TABLE     �   CREATE TABLE public.sucursal (
    codsuc integer NOT NULL,
    nombre character varying(500) NOT NULL,
    telefono character varying(50) NOT NULL,
    estado boolean NOT NULL,
    direccion character varying(300)
);
    DROP TABLE public.sucursal;
       public         heap    postgres    false            �            1259    18267    tipo    TABLE     �   CREATE TABLE public.tipo (
    codtip smallint NOT NULL,
    nomtip character varying(500) NOT NULL,
    estado smallint NOT NULL,
    codcat smallint NOT NULL
);
    DROP TABLE public.tipo;
       public         heap    postgres    false            �           0    0    COLUMN tipo.codtip    COMMENT     :   COMMENT ON COLUMN public.tipo.codtip IS 'codigo de tipo';
          public          postgres    false    240            �           0    0    COLUMN tipo.nomtip    COMMENT     :   COMMENT ON COLUMN public.tipo.nomtip IS 'nombre de tipo';
          public          postgres    false    240            �           0    0    COLUMN tipo.estado    COMMENT     ?   COMMENT ON COLUMN public.tipo.estado IS '1=activo, 0=anulado';
          public          postgres    false    240            �           0    0    COLUMN tipo.codcat    COMMENT     K   COMMENT ON COLUMN public.tipo.codcat IS 'referencia a la tabla categoria';
          public          postgres    false    240            �            1259    18273    tipo_mueble    TABLE     �   CREATE TABLE public.tipo_mueble (
    codtimu integer NOT NULL,
    nombre character varying(100) NOT NULL,
    estado boolean NOT NULL
);
    DROP TABLE public.tipo_mueble;
       public         heap    postgres    false            �            1259    18276    usuario    TABLE     �  CREATE TABLE public.usuario (
    codusu bigint NOT NULL,
    nombre character varying(60) DEFAULT 1 NOT NULL,
    ap character varying(40),
    am character varying(40),
    genero character varying(1) NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    tipoper character varying(1) NOT NULL,
    foto character varying(40),
    ci character varying(15),
    fnac date,
    ecivil character varying(20),
    alias character varying(25)
);
    DROP TABLE public.usuario;
       public         heap    postgres    false            �           0    0    COLUMN usuario.codusu    COMMENT     C   COMMENT ON COLUMN public.usuario.codusu IS 'codigo de la persona';
          public          postgres    false    242            �           0    0    COLUMN usuario.nombre    COMMENT     C   COMMENT ON COLUMN public.usuario.nombre IS 'nombre de la persona';
          public          postgres    false    242            �           0    0    COLUMN usuario.ap    COMMENT     ;   COMMENT ON COLUMN public.usuario.ap IS 'apellido paterno';
          public          postgres    false    242            �           0    0    COLUMN usuario.am    COMMENT     ;   COMMENT ON COLUMN public.usuario.am IS 'apellido materno';
          public          postgres    false    242            �           0    0    COLUMN usuario.genero    COMMENT     O   COMMENT ON COLUMN public.usuario.genero IS 'genero (f=femenino, m=masculino)';
          public          postgres    false    242            �           0    0    COLUMN usuario.estado    COMMENT     B   COMMENT ON COLUMN public.usuario.estado IS '1=activo, 0=anulado';
          public          postgres    false    242            �           0    0    COLUMN usuario.tipoper    COMMENT     K   COMMENT ON COLUMN public.usuario.tipoper IS 'a=administrativo, p=publico';
          public          postgres    false    242            �           0    0    COLUMN usuario.foto    COMMENT     ?   COMMENT ON COLUMN public.usuario.foto IS 'foto de la persona';
          public          postgres    false    242            �           0    0    COLUMN usuario.ci    COMMENT     ?   COMMENT ON COLUMN public.usuario.ci IS 'cedula de la persona';
          public          postgres    false    242            �            1259    18281    venta    TABLE     b  CREATE TABLE public.venta (
    codven bigint NOT NULL,
    fecha date NOT NULL,
    estado smallint DEFAULT 1 NOT NULL,
    codcli bigint NOT NULL,
    tiponota smallint,
    codcaja bigint NOT NULL,
    coddetcaja bigint NOT NULL,
    formapago smallint,
    total real,
    codusu bigint,
    total_pagado real,
    cambio real,
    codsuc integer
);
    DROP TABLE public.venta;
       public         heap    postgres    false            �           0    0    TABLE venta    COMMENT     G   COMMENT ON TABLE public.venta IS '1=pendiente,2=aceptado,3=rechazado';
          public          postgres    false    243            �           0    0    COLUMN venta.codven    COMMENT     <   COMMENT ON COLUMN public.venta.codven IS 'codigo de venta';
          public          postgres    false    243            �           0    0    COLUMN venta.fecha    COMMENT     =   COMMENT ON COLUMN public.venta.fecha IS 'fecha de creacion';
          public          postgres    false    243            �           0    0    COLUMN venta.estado    COMMENT     A   COMMENT ON COLUMN public.venta.estado IS 'estado 1=activo, 0
';
          public          postgres    false    243            �           0    0    COLUMN venta.codcli    COMMENT     >   COMMENT ON COLUMN public.venta.codcli IS 'codigo de cliente';
          public          postgres    false    243            �           0    0    COLUMN venta.tiponota    COMMENT     Q   COMMENT ON COLUMN public.venta.tiponota IS '1=pendiente,2=aceptado,3=rechazado';
          public          postgres    false    243            �           0    0    COLUMN venta.codcaja    COMMENT     C   COMMENT ON COLUMN public.venta.codcaja IS 'referencia tabla caja';
          public          postgres    false    243            �           0    0    COLUMN venta.coddetcaja    COMMENT     T   COMMENT ON COLUMN public.venta.coddetcaja IS 'refencia a la tabla detalle de caja';
          public          postgres    false    243            �           0    0    COLUMN venta.formapago    COMMENT     N   COMMENT ON COLUMN public.venta.formapago IS '1 = al contado, 2 = al credito';
          public          postgres    false    243            �            1259    18285    view_almacen    VIEW     N  CREATE VIEW public.view_almacen AS
 SELECT p.codpro,
    p.nombre,
    p.foto,
    p.codtip,
    p.generico,
    p.codigobarra,
    p.codlab,
    p.concentracion,
    p.codmed,
    p.codare,
    p.pc_unit,
    p.pv_unit,
    p.porcentaje_unidad,
    p.estado,
    p.controlado,
    p.inventario_minimo_unidad,
    p.pareto,
    p.unixcaja,
    p.pc_caja,
    p.pv_caja,
    p.pv_descuento_caja,
    p.unixpaquete,
    p.uni_en_paquete,
    p.inventario_minimo_caja,
    p.inventario_minimo_paquete,
    p.pc_paquete,
    p.pv_paquete,
    p.porcentaje_caja,
    p.porcentaje_paquete,
    p.tipo_compra,
    p.pv_descuento_paquete,
    p.presentacion_unidad,
    p.presentacion_caja,
    p.presentacion_paquete,
    p.margen,
    p.porcentaje_descuento_caja,
    p.porcentaje_descuento_paquete,
    t.nomtip AS xtipo,
    c.nomcat AS xcategoria,
    l.nombre AS xlaboratorio,
    a.nombre AS xarea,
    m.nombre AS xmedida,
    lugar.codsuc,
    sum(almacen.cantidad) AS cantidad
   FROM (((((((public.almacen
     JOIN public.lugar ON ((lugar.codlugar = almacen.codlugar)))
     JOIN public.producto p ON ((p.codpro = lugar.codpro)))
     JOIN public.tipo t ON ((t.codtip = p.codtip)))
     JOIN public.categoria c ON ((c.codcat = t.codcat)))
     JOIN public.laboratorio l ON ((l.codlab = p.codlab)))
     JOIN public.medida m ON ((m.codmed = p.codmed)))
     JOIN public.area a ON ((a.codare = p.codare)))
  GROUP BY p.codpro, p.nombre, p.foto, p.codtip, p.generico, p.codigobarra, p.codlab, p.concentracion, p.codmed, p.codare, p.pc_unit, p.pv_unit, p.porcentaje_unidad, p.estado, p.controlado, p.inventario_minimo_unidad, p.pareto, p.unixcaja, p.pc_caja, p.pv_caja, p.pv_descuento_caja, p.unixpaquete, p.uni_en_paquete, p.inventario_minimo_caja, p.inventario_minimo_paquete, p.pc_paquete, p.pv_paquete, p.porcentaje_caja, p.porcentaje_paquete, p.tipo_compra, p.pv_descuento_paquete, p.presentacion_unidad, p.presentacion_caja, p.presentacion_paquete, p.margen, p.porcentaje_descuento_caja, p.porcentaje_descuento_paquete, t.nomtip, c.nomcat, l.nombre, a.nombre, m.nombre, lugar.codsuc
 HAVING (sum(almacen.cantidad) > 0);
    DROP VIEW public.view_almacen;
       public          postgres    false    222    222    231    231    231    231    231    240    231    240    231    231    231    240    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    231    219    206    206    203    203    202    231    231    231    231    202    231    231    219    220    220    220            �            1259    18290    view_compra    VIEW     z  CREATE VIEW public.view_compra AS
 SELECT compra.codcom,
    compra.fecha,
    compra.estado,
    compra.codusu,
    compra.codpro,
    compra.tiponota,
    compra.total,
    compra.descuento,
    compra.codcaja,
    compra.coddetcaja,
    compra.num,
    compra.formapago,
    compra.bonificacion,
    compra.subtotal,
    compra.numnota,
    compra.codsuc,
    compra.credito,
    compra.estado_credito,
    concat(usuario.nombre, ' ', usuario.ap) AS xusuario,
    proveedor.nombre AS xproveedor,
    to_char(compra.fecha, 'dd/MM/yyyy'::text) AS xfecha,
    ( SELECT COALESCE(sum(pagocredito.monto), (0)::real) AS "coalesce"
           FROM public.pagocredito
          WHERE (pagocredito.codcom = compra.codcom)) AS acuenta
   FROM ((public.compra
     JOIN public.proveedor ON ((proveedor.codproveedor = compra.codpro)))
     JOIN public.usuario ON ((usuario.codusu = compra.codusu)));
    DROP VIEW public.view_compra;
       public          postgres    false    208    208    208    208    208    208    208    208    208    208    208    208    208    208    208    208    208    208    226    226    234    234    242    242    242            �            1259    18295    view_detalle_salida    VIEW     �  CREATE VIEW public.view_detalle_salida AS
 SELECT ds.codsal,
    ds.codalmacen,
    ds.cantidad,
    ds.fingreso,
    ds.fvencimiento,
    ds.is_response,
    ds.in_out,
    l.codlugar,
    p.codpro,
    concat(p.nombre, ' (', p.generico, ')') AS nombre,
    to_char((ds.fingreso)::timestamp with time zone, 'dd/MM/yy'::text) AS xfingreso,
    to_char((ds.fvencimiento)::timestamp with time zone, 'dd/MM/yy'::text) AS xfvencimiento
   FROM (((public.detalle_salida ds
     JOIN public.almacen a ON ((a.codalmacen = ds.codalmacen)))
     JOIN public.lugar l ON ((l.codlugar = a.codlugar)))
     JOIN public.producto p ON ((p.codpro = l.codpro)))
  ORDER BY ds.is_response;
 &   DROP VIEW public.view_detalle_salida;
       public          postgres    false    211    220    220    231    202    202    211    211    231    231    211    211    211    211            �            1259    18300    view_detalle_venta    VIEW     �  CREATE VIEW public.view_detalle_venta AS
 SELECT detalleventa.codpro,
    detalleventa.cantidad,
    detalleventa.codven,
    detalleventa.precio,
    detalleventa.subtotal,
    detalleventa.codalmacen,
    detalleventa.tipo_venta,
    detalleventa.codpromo,
    concat(tipo.nomtip, ' ', producto.nombre, ' (', producto.generico, ') ', producto.concentracion, ' ', medida.nombre) AS xproducto,
    producto.unixcaja,
    producto.unixpaquete,
    public.calcular_cantidad(detalleventa.cantidad, detalleventa.tipo_venta, producto.unixcaja, (producto.unixpaquete)::double precision) AS cantidad_tipo_venta,
    public.tipo_cantidad(detalleventa.tipo_venta) AS xtipo_venta
   FROM (((public.detalleventa
     JOIN public.producto ON ((producto.codpro = detalleventa.codpro)))
     JOIN public.medida ON ((medida.codmed = producto.codmed)))
     JOIN public.tipo ON ((tipo.codtip = producto.codtip)));
 %   DROP VIEW public.view_detalle_venta;
       public          postgres    false    216    216    216    216    216    216    251    240    240    231    231    231    231    231    231    231    231    222    222    216    216    250            �            1259    18305    view_producto    VIEW     �  CREATE VIEW public.view_producto AS
 SELECT p.codpro,
    p.nombre,
    p.estado,
    p.foto,
    p.codtip,
    p.generico,
    p.codigobarra,
    p.codlab,
    p.concentracion,
    p.codmed,
    p.codare,
    p.pc_unit,
    p.pv_unit,
    p.porcentaje_unidad,
    p.codpre,
    p.controlado,
    p.inventario_minimo_unidad,
    p.pareto,
    p.unixcaja,
    p.pv_caja,
    p.pv_descuento_caja,
    p.pc_caja,
    p.unixpaquete,
    p.uni_en_paquete,
    p.inventario_minimo_caja,
    p.inventario_minimo_paquete,
    p.pc_paquete,
    p.pv_paquete,
    p.porcentaje_caja,
    p.porcentaje_paquete,
    p.tipo_compra,
    p.pv_descuento_paquete,
    p.presentacion_unidad,
    p.presentacion_caja,
    p.presentacion_paquete,
    p.margen,
    p.porcentaje_descuento_caja,
    p.porcentaje_descuento_paquete,
    t.nomtip AS xtipo,
    c.nomcat AS xcategoria,
    l.nombre AS xlaboratorio,
    a.nombre AS xarea,
    m.nombre AS xmedida
   FROM (((((public.producto p
     JOIN public.tipo t ON ((t.codtip = p.codtip)))
     JOIN public.categoria c ON ((c.codcat = t.codcat)))
     JOIN public.laboratorio l ON ((l.codlab = p.codlab)))
     JOIN public.medida m ON ((m.codmed = p.codmed)))
     JOIN public.area a ON ((a.codare = p.codare)))
  WHERE (p.estado = 1);
     DROP VIEW public.view_producto;
       public          postgres    false    222    231    231    231    231    231    231    231    231    231    231    240    231    231    231    231    231    231    231    231    231    231    231    231    231    231    240    203    203    206    240    231    231    231    231    231    231    231    231    231    231    231    231    231    206    222    219    219    231            �            1259    18310 
   view_venta    VIEW       CREATE VIEW public.view_venta AS
 SELECT venta.codven,
    venta.fecha,
    venta.estado,
    venta.codcli,
    venta.tiponota,
    venta.codcaja,
    venta.coddetcaja,
    venta.formapago,
    venta.total,
    venta.codusu,
    venta.total_pagado,
    venta.cambio,
    venta.codsuc,
    to_char((venta.fecha)::timestamp with time zone, 'DD/MM/YY'::text) AS xfecha,
    concat(usuario.nombre, ' ', usuario.ap) AS xcliente,
    concat(u.nombre, ' ', u.ap) AS xusuario,
    ( SELECT count(*) AS facturado
           FROM public.factura factura_1
          WHERE ((factura_1.codven = venta.codven) AND ((factura_1.estado)::text = 'activo'::text))) AS facturado,
    factura.cliente_nit,
    factura.nitfac,
    factura.estado AS estado_factura,
    factura.numfac
   FROM ((((public.venta
     JOIN public.cliente ON ((venta.codcli = cliente.codcli)))
     JOIN public.usuario ON ((usuario.codusu = cliente.codcli)))
     JOIN public.usuario u ON ((u.codusu = venta.codusu)))
     LEFT JOIN public.factura ON ((factura.codven = venta.codven)));
    DROP VIEW public.view_venta;
       public          postgres    false    243    243    243    243    243    243    243    243    243    243    243    243    243    242    242    242    218    218    218    218    218    207                      0    18084    acceso_sucursal 
   TABLE DATA           K   COPY public.acceso_sucursal (codusu, codsuc, fecalta, fecbaja) FROM stdin;
    public          postgres    false    200                      0    18087    accesousuario 
   TABLE DATA           F   COPY public.accesousuario (login, passwd, estado, codusu) FROM stdin;
    public          postgres    false    201                       0    18091    almacen 
   TABLE DATA           A   COPY public.almacen (codlugar, cantidad, codalmacen) FROM stdin;
    public          postgres    false    202            !          0    18094    area 
   TABLE DATA           6   COPY public.area (codare, nombre, estado) FROM stdin;
    public          postgres    false    203            "          0    18097    backup 
   TABLE DATA           9   COPY public.backup (cod, xuser, descripcion) FROM stdin;
    public          postgres    false    204            #          0    18103    caja 
   TABLE DATA           z   COPY public.caja (codcaja, codusu, fini, ffin, monini, monfin, monsistema, estado, codsuc, observacion, tipo) FROM stdin;
    public          postgres    false    205            $          0    18110 	   categoria 
   TABLE DATA           ;   COPY public.categoria (codcat, nomcat, estado) FROM stdin;
    public          postgres    false    206            %          0    18116    cliente 
   TABLE DATA           U   COPY public.cliente (estado, nit, direccion, celular, codcli, razon_nit) FROM stdin;
    public          postgres    false    207            &          0    18123    compra 
   TABLE DATA           �   COPY public.compra (codcom, fecha, estado, codusu, codpro, tiponota, total, descuento, codcaja, coddetcaja, num, formapago, bonificacion, subtotal, numnota, codsuc, credito, estado_credito) FROM stdin;
    public          postgres    false    208            '          0    18128    cuenta 
   TABLE DATA           A   COPY public.cuenta (codcuenta, nombre, estado, tipo) FROM stdin;
    public          postgres    false    209            (          0    18131    detalle_margen 
   TABLE DATA           l   COPY public.detalle_margen (cod_margen, number_margin, concept, type_margin, porcentaje_unidad) FROM stdin;
    public          postgres    false    210            )          0    18137    detalle_salida 
   TABLE DATA           s   COPY public.detalle_salida (codsal, codalmacen, cantidad, fingreso, fvencimiento, in_out, is_response) FROM stdin;
    public          postgres    false    211            *          0    18141    detallecaja 
   TABLE DATA           [   COPY public.detallecaja (codcaja, coddetcaja, monto, fecha, estado, codcuenta) FROM stdin;
    public          postgres    false    212            +          0    18145    detallecompra 
   TABLE DATA           �   COPY public.detallecompra (codcom, codpro, cantidad, precio, subtotal, fingreso, fvencimiento, codalmacen, coddcom, impuestos, devolucion, descuento, porcentaje_unidad, porcentaje_caja, porcentaje_paquete, tipo_compra) FROM stdin;
    public          postgres    false    213            ,          0    18148    detallepedido 
   TABLE DATA           S   COPY public.detallepedido (codped, codpro, cantidad, precio, subtotal) FROM stdin;
    public          postgres    false    214            -          0    18151    detallepromo 
   TABLE DATA           m   COPY public.detallepromo (codpromo, codpro, descuento_unidad, descuento_caja, descuento_paquete) FROM stdin;
    public          postgres    false    215            .          0    18154    detalleventa 
   TABLE DATA           t   COPY public.detalleventa (codpro, cantidad, codven, precio, subtotal, codalmacen, tipo_venta, codpromo) FROM stdin;
    public          postgres    false    216            /          0    18157    dosificacion 
   TABLE DATA           �   COPY public.dosificacion (coddosificacion, razonsocial, direccion, telefono, lugar, nit, numaut, actividad, llave, leyenda, mensaje, flimite, ftramite, numtramite, sfc, est, codsuc, sigla, numinifac, numfinfac) FROM stdin;
    public          postgres    false    217            0          0    18163    factura 
   TABLE DATA           �   COPY public.factura (coddosificacion, numfac, fecfac, nitfac, codcontrol, estado, cliente_nit, codven, codcom, total) FROM stdin;
    public          postgres    false    218            1          0    18166    laboratorio 
   TABLE DATA           =   COPY public.laboratorio (codlab, nombre, estado) FROM stdin;
    public          postgres    false    219            2          0    18170    lugar 
   TABLE DATA           F   COPY public.lugar (codsuc, codpro, codposicion, codlugar) FROM stdin;
    public          postgres    false    220            3          0    18173    margen 
   TABLE DATA           X   COPY public.margen (cod_margen, codusu, date_register, observacion, estado) FROM stdin;
    public          postgres    false    221            4          0    18180    medida 
   TABLE DATA           8   COPY public.medida (codmed, nombre, estado) FROM stdin;
    public          postgres    false    222            5          0    18183    menu 
   TABLE DATA           4   COPY public.menu (codm, nombre, estado) FROM stdin;
    public          postgres    false    223            6          0    18187    mepro 
   TABLE DATA           +   COPY public.mepro (codm, codp) FROM stdin;
    public          postgres    false    224            7          0    18190    mueble 
   TABLE DATA           D   COPY public.mueble (codmueble, nombre, estado, codtimu) FROM stdin;
    public          postgres    false    225            8          0    18194    pagocredito 
   TABLE DATA           X   COPY public.pagocredito (codcom, fecha, fecreg, monto, codusu, observacion) FROM stdin;
    public          postgres    false    226            9          0    18200    pedido 
   TABLE DATA           �   COPY public.pedido (codped, fecha, estado, codusu, celular, direccion, observacion, fentrega, coddelivery, nit, razon_nit, codven, codsuc) FROM stdin;
    public          postgres    false    227            :          0    18207    posicion 
   TABLE DATA           J   COPY public.posicion (codposicion, nombre, estado, codmueble) FROM stdin;
    public          postgres    false    228            ;          0    18211    presentacion 
   TABLE DATA           >   COPY public.presentacion (codpre, nombre, estado) FROM stdin;
    public          postgres    false    229            <          0    18217    proceso 
   TABLE DATA           ?   COPY public.proceso (codp, nombre, enlace, estado) FROM stdin;
    public          postgres    false    230            =          0    18221    producto 
   TABLE DATA           ?  COPY public.producto (codpro, nombre, estado, foto, codtip, generico, codigobarra, codlab, concentracion, codmed, codare, pc_unit, pv_unit, porcentaje_unidad, codpre, controlado, inventario_minimo_unidad, pareto, unixcaja, pv_caja, pv_descuento_caja, pc_caja, unixpaquete, uni_en_paquete, inventario_minimo_caja, inventario_minimo_paquete, pc_paquete, pv_paquete, porcentaje_caja, porcentaje_paquete, tipo_compra, pv_descuento_paquete, presentacion_unidad, presentacion_caja, presentacion_paquete, margen, porcentaje_descuento_caja, porcentaje_descuento_paquete) FROM stdin;
    public          postgres    false    231            >          0    18230    producto_nuevo 
   TABLE DATA           \   COPY public.producto_nuevo (cod_pro_nuevo, nombre, descripcion, estado, codusu) FROM stdin;
    public          postgres    false    232            ?          0    18234 	   promocion 
   TABLE DATA           t   COPY public.promocion (codpromo, fcreacion, fini, ffin, titulo, descripcion, codusu, estpromo, gestion) FROM stdin;
    public          postgres    false    233            @          0    18240 	   proveedor 
   TABLE DATA           [   COPY public.proveedor (codproveedor, nombre, nit, direccion, telefono, estado) FROM stdin;
    public          postgres    false    234            A          0    18244    rol 
   TABLE DATA           A   COPY public.rol (codr, nombre, estado, acceso_venta) FROM stdin;
    public          postgres    false    235            B          0    18249    rolme 
   TABLE DATA           +   COPY public.rolme (codr, codm) FROM stdin;
    public          postgres    false    236            C          0    18252    rolusu 
   TABLE DATA           -   COPY public.rolusu (codr, login) FROM stdin;
    public          postgres    false    237            D          0    18255    salida 
   TABLE DATA           �   COPY public.salida (codsal, fsalida, codusu, tipo, descripcion, estado, est, numero, suc_origen, suc_destino, in_out, solucion, monto, conclusion) FROM stdin;
    public          postgres    false    238            E          0    18261    sucursal 
   TABLE DATA           O   COPY public.sucursal (codsuc, nombre, telefono, estado, direccion) FROM stdin;
    public          postgres    false    239            F          0    18267    tipo 
   TABLE DATA           >   COPY public.tipo (codtip, nomtip, estado, codcat) FROM stdin;
    public          postgres    false    240            G          0    18273    tipo_mueble 
   TABLE DATA           >   COPY public.tipo_mueble (codtimu, nombre, estado) FROM stdin;
    public          postgres    false    241            H          0    18276    usuario 
   TABLE DATA           q   COPY public.usuario (codusu, nombre, ap, am, genero, estado, tipoper, foto, ci, fnac, ecivil, alias) FROM stdin;
    public          postgres    false    242            I          0    18281    venta 
   TABLE DATA           �   COPY public.venta (codven, fecha, estado, codcli, tiponota, codcaja, coddetcaja, formapago, total, codusu, total_pagado, cambio, codsuc) FROM stdin;
    public          postgres    false    243                       2606    18316 "   acceso_sucursal acceso_sucursal_pk 
   CONSTRAINT     u   ALTER TABLE ONLY public.acceso_sucursal
    ADD CONSTRAINT acceso_sucursal_pk PRIMARY KEY (codusu, codsuc, fecalta);
 L   ALTER TABLE ONLY public.acceso_sucursal DROP CONSTRAINT acceso_sucursal_pk;
       public            postgres    false    200    200    200                       2606    18318    almacen almacen6_pk 
   CONSTRAINT     Y   ALTER TABLE ONLY public.almacen
    ADD CONSTRAINT almacen6_pk PRIMARY KEY (codalmacen);
 =   ALTER TABLE ONLY public.almacen DROP CONSTRAINT almacen6_pk;
       public            postgres    false    202            8           2606    18320    lugar almacen_pk 
   CONSTRAINT     T   ALTER TABLE ONLY public.lugar
    ADD CONSTRAINT almacen_pk PRIMARY KEY (codlugar);
 :   ALTER TABLE ONLY public.lugar DROP CONSTRAINT almacen_pk;
       public            postgres    false    220                       2606    18322    area area_pk 
   CONSTRAINT     N   ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pk PRIMARY KEY (codare);
 6   ALTER TABLE ONLY public.area DROP CONSTRAINT area_pk;
       public            postgres    false    203                       2606    18324    backup backup_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.backup
    ADD CONSTRAINT backup_pkey PRIMARY KEY (cod);
 <   ALTER TABLE ONLY public.backup DROP CONSTRAINT backup_pkey;
       public            postgres    false    204                       2606    18326    caja caja_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.caja
    ADD CONSTRAINT caja_pkey PRIMARY KEY (codcaja);
 8   ALTER TABLE ONLY public.caja DROP CONSTRAINT caja_pkey;
       public            postgres    false    205                       2606    18328    categoria categoria_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (codcat);
 B   ALTER TABLE ONLY public.categoria DROP CONSTRAINT categoria_pkey;
       public            postgres    false    206                       2606    18330    cliente cliente_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (codcli);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    207                        2606    18332    compra compra_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_pkey PRIMARY KEY (codcom);
 <   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_pkey;
       public            postgres    false    208            "           2606    18334    cuenta cuenta_pk 
   CONSTRAINT     U   ALTER TABLE ONLY public.cuenta
    ADD CONSTRAINT cuenta_pk PRIMARY KEY (codcuenta);
 :   ALTER TABLE ONLY public.cuenta DROP CONSTRAINT cuenta_pk;
       public            postgres    false    209            $           2606    18336 "   detalle_margen detalle_margen_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.detalle_margen
    ADD CONSTRAINT detalle_margen_pkey PRIMARY KEY (cod_margen, number_margin);
 L   ALTER TABLE ONLY public.detalle_margen DROP CONSTRAINT detalle_margen_pkey;
       public            postgres    false    210    210            &           2606    18338 "   detalle_salida detalle_salida_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.detalle_salida
    ADD CONSTRAINT detalle_salida_pkey PRIMARY KEY (codsal, codalmacen);
 L   ALTER TABLE ONLY public.detalle_salida DROP CONSTRAINT detalle_salida_pkey;
       public            postgres    false    211    211            (           2606    18340    detallecaja detallecaja_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.detallecaja
    ADD CONSTRAINT detallecaja_pkey PRIMARY KEY (codcaja, coddetcaja);
 F   ALTER TABLE ONLY public.detallecaja DROP CONSTRAINT detallecaja_pkey;
       public            postgres    false    212    212            *           2606    18342    detallecompra detallecompra_pk 
   CONSTRAINT     i   ALTER TABLE ONLY public.detallecompra
    ADD CONSTRAINT detallecompra_pk PRIMARY KEY (codcom, coddcom);
 H   ALTER TABLE ONLY public.detallecompra DROP CONSTRAINT detallecompra_pk;
       public            postgres    false    213    213            ,           2606    18344     detallepedido detallepedido_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT detallepedido_pkey PRIMARY KEY (codped, codpro);
 J   ALTER TABLE ONLY public.detallepedido DROP CONSTRAINT detallepedido_pkey;
       public            postgres    false    214    214            .           2606    18346    detallepromo detallepromo_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.detallepromo
    ADD CONSTRAINT detallepromo_pkey PRIMARY KEY (codpromo, codpro);
 H   ALTER TABLE ONLY public.detallepromo DROP CONSTRAINT detallepromo_pkey;
       public            postgres    false    215    215            0           2606    18348    detalleventa detalleventa_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.detalleventa
    ADD CONSTRAINT detalleventa_pkey PRIMARY KEY (codpro, codven);
 H   ALTER TABLE ONLY public.detalleventa DROP CONSTRAINT detalleventa_pkey;
       public            postgres    false    216    216            2           2606    18350    dosificacion dosificacion_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.dosificacion
    ADD CONSTRAINT dosificacion_pkey PRIMARY KEY (coddosificacion);
 H   ALTER TABLE ONLY public.dosificacion DROP CONSTRAINT dosificacion_pkey;
       public            postgres    false    217            4           2606    18352    factura factura_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_pkey PRIMARY KEY (coddosificacion, numfac);
 >   ALTER TABLE ONLY public.factura DROP CONSTRAINT factura_pkey;
       public            postgres    false    218    218            6           2606    18354    laboratorio laboratorio_pk 
   CONSTRAINT     \   ALTER TABLE ONLY public.laboratorio
    ADD CONSTRAINT laboratorio_pk PRIMARY KEY (codlab);
 D   ALTER TABLE ONLY public.laboratorio DROP CONSTRAINT laboratorio_pk;
       public            postgres    false    219            :           2606    18356    margen margen_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.margen
    ADD CONSTRAINT margen_pkey PRIMARY KEY (cod_margen);
 <   ALTER TABLE ONLY public.margen DROP CONSTRAINT margen_pkey;
       public            postgres    false    221            <           2606    18358    medida medida_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.medida
    ADD CONSTRAINT medida_pk PRIMARY KEY (codmed);
 :   ALTER TABLE ONLY public.medida DROP CONSTRAINT medida_pk;
       public            postgres    false    222            >           2606    18360    menu menus_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menus_pkey PRIMARY KEY (codm);
 9   ALTER TABLE ONLY public.menu DROP CONSTRAINT menus_pkey;
       public            postgres    false    223            @           2606    18362    mepro mepro_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.mepro
    ADD CONSTRAINT mepro_pkey PRIMARY KEY (codm, codp);
 :   ALTER TABLE ONLY public.mepro DROP CONSTRAINT mepro_pkey;
       public            postgres    false    224    224            B           2606    18364    mueble mueble_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.mueble
    ADD CONSTRAINT mueble_pkey PRIMARY KEY (codmueble);
 <   ALTER TABLE ONLY public.mueble DROP CONSTRAINT mueble_pkey;
       public            postgres    false    225            b           2606    18366    tipo_mueble newtable_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public.tipo_mueble
    ADD CONSTRAINT newtable_pk PRIMARY KEY (codtimu);
 A   ALTER TABLE ONLY public.tipo_mueble DROP CONSTRAINT newtable_pk;
       public            postgres    false    241            D           2606    18368    pagocredito pagocredito_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.pagocredito
    ADD CONSTRAINT pagocredito_pkey PRIMARY KEY (codcom);
 F   ALTER TABLE ONLY public.pagocredito DROP CONSTRAINT pagocredito_pkey;
       public            postgres    false    226            F           2606    18370    pedido pedido_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (codped);
 <   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pedido_pkey;
       public            postgres    false    227            d           2606    18372    usuario personas_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT personas_pkey PRIMARY KEY (codusu);
 ?   ALTER TABLE ONLY public.usuario DROP CONSTRAINT personas_pkey;
       public            postgres    false    242            H           2606    18374    posicion posicion_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.posicion
    ADD CONSTRAINT posicion_pkey PRIMARY KEY (codposicion);
 @   ALTER TABLE ONLY public.posicion DROP CONSTRAINT posicion_pkey;
       public            postgres    false    228            J           2606    18376    presentacion presentacion_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.presentacion
    ADD CONSTRAINT presentacion_pkey PRIMARY KEY (codpre);
 H   ALTER TABLE ONLY public.presentacion DROP CONSTRAINT presentacion_pkey;
       public            postgres    false    229            L           2606    18378    proceso procesos_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.proceso
    ADD CONSTRAINT procesos_pkey PRIMARY KEY (codp);
 ?   ALTER TABLE ONLY public.proceso DROP CONSTRAINT procesos_pkey;
       public            postgres    false    230            P           2606    18380 "   producto_nuevo producto_nuevo_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.producto_nuevo
    ADD CONSTRAINT producto_nuevo_pkey PRIMARY KEY (cod_pro_nuevo);
 L   ALTER TABLE ONLY public.producto_nuevo DROP CONSTRAINT producto_nuevo_pkey;
       public            postgres    false    232            N           2606    18382    producto producto_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (codpro);
 @   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_pkey;
       public            postgres    false    231            R           2606    18384    promocion promocion_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.promocion
    ADD CONSTRAINT promocion_pkey PRIMARY KEY (codpromo);
 B   ALTER TABLE ONLY public.promocion DROP CONSTRAINT promocion_pkey;
       public            postgres    false    233            T           2606    18386    proveedor proveedor_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT proveedor_pkey PRIMARY KEY (codproveedor);
 B   ALTER TABLE ONLY public.proveedor DROP CONSTRAINT proveedor_pkey;
       public            postgres    false    234            V           2606    18388    rol roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.rol
    ADD CONSTRAINT roles_pkey PRIMARY KEY (codr);
 8   ALTER TABLE ONLY public.rol DROP CONSTRAINT roles_pkey;
       public            postgres    false    235            X           2606    18390    rolme rolme_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.rolme
    ADD CONSTRAINT rolme_pkey PRIMARY KEY (codr, codm);
 :   ALTER TABLE ONLY public.rolme DROP CONSTRAINT rolme_pkey;
       public            postgres    false    236    236            Z           2606    18392    rolusu rolusu_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.rolusu
    ADD CONSTRAINT rolusu_pkey PRIMARY KEY (codr, login);
 <   ALTER TABLE ONLY public.rolusu DROP CONSTRAINT rolusu_pkey;
       public            postgres    false    237    237            \           2606    18394    salida salida_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.salida
    ADD CONSTRAINT salida_pkey PRIMARY KEY (codsal);
 <   ALTER TABLE ONLY public.salida DROP CONSTRAINT salida_pkey;
       public            postgres    false    238            ^           2606    18396    sucursal sucursal_pk 
   CONSTRAINT     V   ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT sucursal_pk PRIMARY KEY (codsuc);
 >   ALTER TABLE ONLY public.sucursal DROP CONSTRAINT sucursal_pk;
       public            postgres    false    239            `           2606    18398    tipo tipo_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.tipo
    ADD CONSTRAINT tipo_pkey PRIMARY KEY (codtip);
 8   ALTER TABLE ONLY public.tipo DROP CONSTRAINT tipo_pkey;
       public            postgres    false    240                       2606    18400 !   accesousuario usuarios_codper_key 
   CONSTRAINT     ^   ALTER TABLE ONLY public.accesousuario
    ADD CONSTRAINT usuarios_codper_key UNIQUE (codusu);
 K   ALTER TABLE ONLY public.accesousuario DROP CONSTRAINT usuarios_codper_key;
       public            postgres    false    201                       2606    18402    accesousuario usuarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.accesousuario
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (login);
 E   ALTER TABLE ONLY public.accesousuario DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    201            f           2606    18404    venta venta_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (codven);
 :   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_pkey;
       public            postgres    false    243            g           2606    18405 +   acceso_sucursal acceso_sucursal_sucursal_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.acceso_sucursal
    ADD CONSTRAINT acceso_sucursal_sucursal_fk FOREIGN KEY (codsuc) REFERENCES public.sucursal(codsuc);
 U   ALTER TABLE ONLY public.acceso_sucursal DROP CONSTRAINT acceso_sucursal_sucursal_fk;
       public          postgres    false    239    200    3166            h           2606    18410 +   acceso_sucursal acceso_sucursal_usuarios_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.acceso_sucursal
    ADD CONSTRAINT acceso_sucursal_usuarios_fk FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 U   ALTER TABLE ONLY public.acceso_sucursal DROP CONSTRAINT acceso_sucursal_usuarios_fk;
       public          postgres    false    200    242    3172            j           2606    18415    almacen almacen_lugar_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.almacen
    ADD CONSTRAINT almacen_lugar_fk FOREIGN KEY (codlugar) REFERENCES public.lugar(codlugar);
 B   ALTER TABLE ONLY public.almacen DROP CONSTRAINT almacen_lugar_fk;
       public          postgres    false    3128    202    220            k           2606    18420    caja caja_codusu_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.caja
    ADD CONSTRAINT caja_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 ?   ALTER TABLE ONLY public.caja DROP CONSTRAINT caja_codusu_fkey;
       public          postgres    false    242    205    3172            l           2606    18425    caja caja_sucursal_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public.caja
    ADD CONSTRAINT caja_sucursal_fk FOREIGN KEY (codsuc) REFERENCES public.sucursal(codsuc);
 ?   ALTER TABLE ONLY public.caja DROP CONSTRAINT caja_sucursal_fk;
       public          postgres    false    239    205    3166            m           2606    18430    cliente cliente_codcli_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_codcli_fkey FOREIGN KEY (codcli) REFERENCES public.usuario(codusu);
 E   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_codcli_fkey;
       public          postgres    false    3172    242    207            n           2606    18435    compra compra_codpro_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_codpro_fkey FOREIGN KEY (codpro) REFERENCES public.proveedor(codproveedor);
 C   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_codpro_fkey;
       public          postgres    false    234    208    3156            o           2606    18440    compra compra_codusu_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 C   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_codusu_fkey;
       public          postgres    false    3172    208    242            p           2606    18445    compra compra_detallecaja_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_detallecaja_fk FOREIGN KEY (codcaja, coddetcaja) REFERENCES public.detallecaja(codcaja, coddetcaja);
 F   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_detallecaja_fk;
       public          postgres    false    3112    208    212    208    212            q           2606    18450 -   detalle_margen detalle_margen_cod_margen_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_margen
    ADD CONSTRAINT detalle_margen_cod_margen_fkey FOREIGN KEY (cod_margen) REFERENCES public.margen(cod_margen);
 W   ALTER TABLE ONLY public.detalle_margen DROP CONSTRAINT detalle_margen_cod_margen_fkey;
       public          postgres    false    221    210    3130            r           2606    18455 )   detalle_salida detalle_salida_codsal_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_salida
    ADD CONSTRAINT detalle_salida_codsal_fkey FOREIGN KEY (codsal) REFERENCES public.salida(codsal);
 S   ALTER TABLE ONLY public.detalle_salida DROP CONSTRAINT detalle_salida_codsal_fkey;
       public          postgres    false    211    3164    238            s           2606    18460 $   detallecaja detallecaja_codcaja_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallecaja
    ADD CONSTRAINT detallecaja_codcaja_fkey FOREIGN KEY (codcaja) REFERENCES public.caja(codcaja);
 N   ALTER TABLE ONLY public.detallecaja DROP CONSTRAINT detallecaja_codcaja_fkey;
       public          postgres    false    212    205    3098            t           2606    18465 !   detallecaja detallecaja_cuenta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallecaja
    ADD CONSTRAINT detallecaja_cuenta_fk FOREIGN KEY (codcuenta) REFERENCES public.cuenta(codcuenta);
 K   ALTER TABLE ONLY public.detallecaja DROP CONSTRAINT detallecaja_cuenta_fk;
       public          postgres    false    212    209    3106            u           2606    18470 &   detallecompra detallecompra_almacen_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallecompra
    ADD CONSTRAINT detallecompra_almacen_fk FOREIGN KEY (codalmacen) REFERENCES public.almacen(codalmacen);
 P   ALTER TABLE ONLY public.detallecompra DROP CONSTRAINT detallecompra_almacen_fk;
       public          postgres    false    213    3092    202            v           2606    18475 '   detallecompra detallecompra_codcom_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallecompra
    ADD CONSTRAINT detallecompra_codcom_fkey FOREIGN KEY (codcom) REFERENCES public.compra(codcom);
 Q   ALTER TABLE ONLY public.detallecompra DROP CONSTRAINT detallecompra_codcom_fkey;
       public          postgres    false    3104    208    213            w           2606    18480 '   detallepedido detallepedido_codped_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT detallepedido_codped_fkey FOREIGN KEY (codped) REFERENCES public.pedido(codped);
 Q   ALTER TABLE ONLY public.detallepedido DROP CONSTRAINT detallepedido_codped_fkey;
       public          postgres    false    3142    214    227            x           2606    18485 '   detallepromo detallepromo_codpromo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallepromo
    ADD CONSTRAINT detallepromo_codpromo_fkey FOREIGN KEY (codpromo) REFERENCES public.promocion(codpromo);
 Q   ALTER TABLE ONLY public.detallepromo DROP CONSTRAINT detallepromo_codpromo_fkey;
       public          postgres    false    215    3154    233            y           2606    18490 #   detalleventa detalleventa_codv_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalleventa
    ADD CONSTRAINT detalleventa_codv_fkey FOREIGN KEY (codven) REFERENCES public.venta(codven);
 M   ALTER TABLE ONLY public.detalleventa DROP CONSTRAINT detalleventa_codv_fkey;
       public          postgres    false    3174    216    243            z           2606    18495 %   dosificacion dosificacion_sucursal_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.dosificacion
    ADD CONSTRAINT dosificacion_sucursal_fk FOREIGN KEY (codsuc) REFERENCES public.sucursal(codsuc);
 O   ALTER TABLE ONLY public.dosificacion DROP CONSTRAINT dosificacion_sucursal_fk;
       public          postgres    false    217    239    3166            {           2606    18500    factura factura_ibfk_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_ibfk_1 FOREIGN KEY (coddosificacion) REFERENCES public.dosificacion(coddosificacion);
 @   ALTER TABLE ONLY public.factura DROP CONSTRAINT factura_ibfk_1;
       public          postgres    false    217    218    3122            |           2606    18505    lugar lugar_posicion_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lugar
    ADD CONSTRAINT lugar_posicion_fk FOREIGN KEY (codposicion) REFERENCES public.posicion(codposicion);
 A   ALTER TABLE ONLY public.lugar DROP CONSTRAINT lugar_posicion_fk;
       public          postgres    false    228    3144    220            }           2606    18510    lugar lugar_producto_fk    FK CONSTRAINT     |   ALTER TABLE ONLY public.lugar
    ADD CONSTRAINT lugar_producto_fk FOREIGN KEY (codpro) REFERENCES public.producto(codpro);
 A   ALTER TABLE ONLY public.lugar DROP CONSTRAINT lugar_producto_fk;
       public          postgres    false    220    3150    231            ~           2606    18515    lugar lugar_sucursal_fk    FK CONSTRAINT     |   ALTER TABLE ONLY public.lugar
    ADD CONSTRAINT lugar_sucursal_fk FOREIGN KEY (codsuc) REFERENCES public.sucursal(codsuc);
 A   ALTER TABLE ONLY public.lugar DROP CONSTRAINT lugar_sucursal_fk;
       public          postgres    false    239    3166    220                       2606    18520    margen margen_codusu_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.margen
    ADD CONSTRAINT margen_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 C   ALTER TABLE ONLY public.margen DROP CONSTRAINT margen_codusu_fkey;
       public          postgres    false    221    242    3172            �           2606    18525    mepro mepro_codm_fkey    FK CONSTRAINT     r   ALTER TABLE ONLY public.mepro
    ADD CONSTRAINT mepro_codm_fkey FOREIGN KEY (codm) REFERENCES public.menu(codm);
 ?   ALTER TABLE ONLY public.mepro DROP CONSTRAINT mepro_codm_fkey;
       public          postgres    false    3134    224    223            �           2606    18530    mepro mepro_codp_fkey    FK CONSTRAINT     u   ALTER TABLE ONLY public.mepro
    ADD CONSTRAINT mepro_codp_fkey FOREIGN KEY (codp) REFERENCES public.proceso(codp);
 ?   ALTER TABLE ONLY public.mepro DROP CONSTRAINT mepro_codp_fkey;
       public          postgres    false    3148    224    230            �           2606    18535    mueble mueble_tipo_mueble_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.mueble
    ADD CONSTRAINT mueble_tipo_mueble_fk FOREIGN KEY (codtimu) REFERENCES public.tipo_mueble(codtimu);
 F   ALTER TABLE ONLY public.mueble DROP CONSTRAINT mueble_tipo_mueble_fk;
       public          postgres    false    225    241    3170            �           2606    18540 #   pagocredito pagocredito_codcom_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagocredito
    ADD CONSTRAINT pagocredito_codcom_fkey FOREIGN KEY (codcom) REFERENCES public.compra(codcom);
 M   ALTER TABLE ONLY public.pagocredito DROP CONSTRAINT pagocredito_codcom_fkey;
       public          postgres    false    3104    226    208            �           2606    18545    pedido pedido_codusu_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 C   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pedido_codusu_fkey;
       public          postgres    false    242    3172    227            �           2606    18550    posicion posicion_mueble_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.posicion
    ADD CONSTRAINT posicion_mueble_fk FOREIGN KEY (codmueble) REFERENCES public.mueble(codmueble);
 E   ALTER TABLE ONLY public.posicion DROP CONSTRAINT posicion_mueble_fk;
       public          postgres    false    228    225    3138            �           2606    18555    producto producto_area_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_area_fk FOREIGN KEY (codare) REFERENCES public.area(codare);
 C   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_area_fk;
       public          postgres    false    203    3094    231            �           2606    18560    producto producto_codtip_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_codtip_fkey FOREIGN KEY (codtip) REFERENCES public.tipo(codtip);
 G   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_codtip_fkey;
       public          postgres    false    3168    231    240            �           2606    18565     producto producto_laboratorio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_laboratorio_fk FOREIGN KEY (codlab) REFERENCES public.laboratorio(codlab);
 J   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_laboratorio_fk;
       public          postgres    false    231    219    3126            �           2606    18570    producto producto_medida_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_medida_fk FOREIGN KEY (codmed) REFERENCES public.medida(codmed);
 E   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_medida_fk;
       public          postgres    false    231    222    3132            �           2606    18575 !   producto producto_presentacion_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_presentacion_fk FOREIGN KEY (codpre) REFERENCES public.presentacion(codpre);
 K   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_presentacion_fk;
       public          postgres    false    229    231    3146            �           2606    18580    promocion promocion_codusu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.promocion
    ADD CONSTRAINT promocion_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 I   ALTER TABLE ONLY public.promocion DROP CONSTRAINT promocion_codusu_fkey;
       public          postgres    false    3172    242    233            �           2606    18585 %   proveedor proveedor_codproveedor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT proveedor_codproveedor_fkey FOREIGN KEY (codproveedor) REFERENCES public.usuario(codusu);
 O   ALTER TABLE ONLY public.proveedor DROP CONSTRAINT proveedor_codproveedor_fkey;
       public          postgres    false    242    234    3172            �           2606    18590    rolme rolme_codm_fkey    FK CONSTRAINT     r   ALTER TABLE ONLY public.rolme
    ADD CONSTRAINT rolme_codm_fkey FOREIGN KEY (codm) REFERENCES public.menu(codm);
 ?   ALTER TABLE ONLY public.rolme DROP CONSTRAINT rolme_codm_fkey;
       public          postgres    false    236    223    3134            �           2606    18595    rolme rolme_rolme_fkey    FK CONSTRAINT     r   ALTER TABLE ONLY public.rolme
    ADD CONSTRAINT rolme_rolme_fkey FOREIGN KEY (codr) REFERENCES public.rol(codr);
 @   ALTER TABLE ONLY public.rolme DROP CONSTRAINT rolme_rolme_fkey;
       public          postgres    false    3158    235    236            �           2606    18600    rolusu rolusu_codr_fkey    FK CONSTRAINT     s   ALTER TABLE ONLY public.rolusu
    ADD CONSTRAINT rolusu_codr_fkey FOREIGN KEY (codr) REFERENCES public.rol(codr);
 A   ALTER TABLE ONLY public.rolusu DROP CONSTRAINT rolusu_codr_fkey;
       public          postgres    false    237    235    3158            �           2606    18605    rolusu rolusu_login_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.rolusu
    ADD CONSTRAINT rolusu_login_fkey FOREIGN KEY (login) REFERENCES public.accesousuario(login);
 B   ALTER TABLE ONLY public.rolusu DROP CONSTRAINT rolusu_login_fkey;
       public          postgres    false    3090    237    201            �           2606    18610    salida salida_codusu_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.salida
    ADD CONSTRAINT salida_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 C   ALTER TABLE ONLY public.salida DROP CONSTRAINT salida_codusu_fkey;
       public          postgres    false    242    238    3172            �           2606    18615    salida salida_suc_destino_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.salida
    ADD CONSTRAINT salida_suc_destino_fkey FOREIGN KEY (suc_destino) REFERENCES public.sucursal(codsuc);
 H   ALTER TABLE ONLY public.salida DROP CONSTRAINT salida_suc_destino_fkey;
       public          postgres    false    239    3166    238            �           2606    18620    salida salida_suc_origen_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.salida
    ADD CONSTRAINT salida_suc_origen_fkey FOREIGN KEY (suc_origen) REFERENCES public.sucursal(codsuc);
 G   ALTER TABLE ONLY public.salida DROP CONSTRAINT salida_suc_origen_fkey;
       public          postgres    false    238    3166    239            �           2606    18625    tipo tipo_codcat_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.tipo
    ADD CONSTRAINT tipo_codcat_fkey FOREIGN KEY (codcat) REFERENCES public.categoria(codcat);
 ?   ALTER TABLE ONLY public.tipo DROP CONSTRAINT tipo_codcat_fkey;
       public          postgres    false    3100    240    206            i           2606    18630 "   accesousuario usuarios_codusu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.accesousuario
    ADD CONSTRAINT usuarios_codusu_fkey FOREIGN KEY (codusu) REFERENCES public.usuario(codusu);
 L   ALTER TABLE ONLY public.accesousuario DROP CONSTRAINT usuarios_codusu_fkey;
       public          postgres    false    201    242    3172            �           2606    18635    venta venta_codcaja_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_codcaja_fkey FOREIGN KEY (codcaja, coddetcaja) REFERENCES public.detallecaja(codcaja, coddetcaja);
 B   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_codcaja_fkey;
       public          postgres    false    3112    212    243    212    243               �   x����m1�}U\"��C"�H�t��v�|�̊��"�dc4�]�\��3���)�$�ұ�Os�R'�����7��#.ׯI��T�{����9�(��~z���b(co�?M�T�H;�/�ؚ�.��F�fCr�@���в������b4�.��˙7B��y�,[�~�;�o��r�&u1��v{EbR�q��ȼ=�z��Dn3�sŁ��g��Q�9%s�l���l"���گ�m�7�Ņ[         �   x�-��� ����~��G���DhKd��j�O/%\v&�d�%fB��4_�;�4���Ռb��
�zT�,K�<郲��`��2#�R��`)�m'�鎎�kO	OP�������C ȑ��]���ȷ3�8#/�             x�D�Q��8D�������WD���9a]�#���28����=�w�������L���������<�;xpx��O�^������������Q�4�y�j^A��3hT���	ս�����nT�Qݍj3��QmFu7�ͨ�F��ݨ6�������4���6�F��`��~�F���F����껃��{���;�F�5��a|�jk_����aT[�؍jk�Qmc7��a�F�5�ݨ����0�c7�o����0v��6��0�����o;:�h/�!�ޘ�1�r������~��m{��hG����tD����;�ẹ1_�<
u	u��,�%�Y�)�Y�)�Y�)�U�)T��)�m����Z�Yu�~V�Cu�嬺���T�g�{*��=?+�t���S��U�`�*�T�gz*س
=�Y��
��$OzU����*�S^U٩���TeWut*�k+�:�*�S�\Ωp�*�T)W�q*�k�l��ٸ��S-\�©�����W�J���?%��7�� ��S-\{��P{��P{��PG��PG��PUʩR�*�T)�����xO�;:���V8�¹*�S�\Ωp�
�T8W�s*��l�0Ά1�l�0���A��a�Ы�9W�|k���V8����F�����iN��iN��iN��iN��iN�s�k2B�:�������������Fx9�Q�K�Q�K��P�Pg�.��
�U8�
�U8�
�U8�
�U8�BM��.��9'�^��P�ʙ�ə�8ɏ3	qRg��$!Θ�D�gT~b�+�>Q�Y�����Od}E�'v���_����İW�z��+=q���8�%O,y����J�S�^��)E�R����^�C�H�D�W�y"�+�<��ujU��R�*EO)zš'�J�S^e�)뮲�uWYwʺ��;e�K�X�z8�~���Qd�<~��)HY�t��^�Jl{Ю�V7���[�Nc?�B��ٱ`�+�=1���*�O�|�ɧL�b��^%�)��2���W�{b�+�0��^���j/T{E�����볺\GD\	�� � 'pUP���b�볶�A�P}]���/�~��N�"��_Uߥ�f$~!��_H|F������g$~!�Y1^�q�ؗĞ%�%�g�}Ɍ�](oFyʛ��%�g��ҊgZ�V3ʻPތ�.�7���Z�v(oFyʛi�K�Ϫ�R���d�,c��Bu�Z�,�/	<�̗�<��K-�����3����,�.y5K�Kz���f�4���,ͦ4��ٔf�4��l��Sz��{J�Y�Mi6�s[�������lJ���?���&?5��&?5��4���NN��O]���O]���O]�N�M��N�M��N�M��N�M��N�M��N�M�ﮫO]�N�L:�N�L:�N�L:��Z��%�,���SϿ����z����ja���Z�j�����ڿ��M_]�k]�.���h�Bӳ+x���+x��3y��3=��3����L�_���
^��L�_����/4=���:���:���:���+8S�%9���+8���+8���+8�F�k4�(׹��V@+δ�E+�h�B�3�xъ3�~��3־����/�=c�kϴ�E+δ�E+�H�B�3Ҽ��������4g�y!�iN�9#͉4g�9�挼&��D^���rrF^y�Rtn�3����.'���#�����k"�;����.'����cNs̻��r�n�9�1�rr�ɻ��r�N:�c�:^4W�?��"�{Qi�{�m�T�ʜT�ʜT�ʜd�]6O�|G�ߑ�D�w�;���N�{G���e��w�<e�]6O�|��S6���D�wt;���N�zG���1�Ġw�9e&�/�F�w�k��r�8��3θp���^��3.�1����9�Fױ�U�K�&p��].��].ٌB�E!)�I�ܕ�T�w��T�c�Wc{
�wp�7��z�/p�������B=�{|G|���_�x�Ǘ?�wAx������O<�_p�^��B]��B]����
uuu��ß���gGt;���i��#�׼���k^4���F�O��fTw�7��F_����_���)�X䧵=��O/{�����
��+�V��P[�v��B�Bm��t,�.�Ȼ���/p�`��T�;�Oi�}o�ö{����v�voTè�B��B��B����t�G�{:ޣ<�� OX�%�^�%�>
u	5�%�٨��~J-�g��%�x}�����\��OD~G�s��жfwS�ijq7���w�?���O�G@sP�?���O���7ֿc��߱����������X���o�G������n�I�޺�'ֿu�O4+�O��[i|R����D����Do��&n�����x�Q�`Ð����#���衉J-|��G݃E>D�&n������aG��R>��R>�4n���o���v;uJ��?���x�IG�P*���*���h�S�?�����IG�Pג����I�,��Rx�,��Rx�,�4�J�IN�P�P�C>�C>�C>��K|�%���d�?�>h�-|��'��H�-���-���-�H�-�H�-�H�-�H�-�H�-��yt��{w���5i���M��&��M��M�����w7n7�����M��M�����wӁ�t�n�z��ϧP(����v�>Mn��ӌ��z>�Xo�������J���uA�,<�,�.T���~R�7
�4Y�q��}U��ƙ�f��a���3?	�I~��>�|����Fw��i��*�X��}�G���2�T���>���}�iv#�OTv}�4�M�}�7��I��Tާ$���OIx�kۆqF7��,u5���P�����%�G�Y}DN�}��O��C�}}��sj*����[J������wm)��R�9�}�rr�
%'��m%ᖎ�H�mk[ܵ%�>�pK�}pזp�H���!H�m�l �m�l �-����[��3�0
���䇜ܾ�¨۷�4�o'�n�"c�-u���[��R����n{�Q��n{�TG�� ��v4Hu��.?�喺���-u�A�[��C]n�P�l�Re[����Q(E�5��(�-u�Y����Kng�
Knʹ>fZ[3��ܚi}���L���m�6�V�m�m�V�m�n��6U�Ue�*۪�M�mU٦ʶ�lSe[U����*�T��S(D��C7D��C7D��C7��C7��C7��C7��C7��C�%E��HT���?ğb���mQ�sE�|ԩ���K�ň�)ƙ�i�����>��z�VO�z�V�*�V�*�V�*�V^���V^���V^����6=�[��o�)�o=`��M�6����m#I�Ц��Ц��Ц��Ц��%��T}K��^��<P2~KƯd���_��M�})�o
�K�}˾���&پ$�^�����~���~��d�C�oG�����¥ȷ�P$�6
E�oMV?$��d�C�oݩ���[��	�5Y���[7n>8|����oݸ����,ѽ]�"���Q��ը���jTD�֍�ѽu��Ctoݸ��[���7�*�$�F�o]��ݺ��g�>+ԺS�n�����J��n���n���n���m8��m8��n��kmX�kmX��n��Mmh�Mmh�[^m��[^m��["m�["m�m��m��m�*�BI�o��I�o���o���o���u��P�["m�["m�["m�["m�Mm��#V��({���]�����	�:�^'��{����u¯N��	�:�^'��{B�;ֽ��u���ŗ�ػd_�l�|���K�u��:�W'ܻ��k�.�}��{2�Kf���/����_ɿ'3�d�^-|��^-|�BOQ�G�(ã��S��Q��)��hk�lvx�5z6;<�=�m�����F�f�G[�g�ó��������j�<cx>z�1<=A^������]ixx5z�1<�=��V=�Ph�{|�3��Ï�������H|��cx$>��7<��{��^ixB>��7<r�������ó���}x�5��ϲFs��Y�h�><��݇T������-�r�1F�tz�O�gY]���S&K)mcI��V�?W��s�Ŀ}��F#ul���`�����?��w�    ��2Q����9���˼�JA^�WP.�~� /S�+y�\iċ�҈���.��J�]D�{\D�{\D��d����d���$�ep�-�9��\H��[.�}%�.�}E5�9��<� �y�� o�<�m�G�o����������ኗ.�~%�.��'S��b���ኵ�5ؓ?_�g�4���^i~5���k��\���l�J����W�ٛ>}����鋵�T}�֞��.��4�����{zg����ήo��]���;��Ԟ���٨Rv���J���==��M���\�Lv��#2�ͦ��d7�:"�]�:"�]�:��]�:��]�:��]�8��]�:���\�hr��[��/�J�:����֑����#ٵ�[G�k�f3;v��;v��;J?�;�kPG��]<"��\�hr���1ώK��gǥG̳��#��q�Qz�4ڑ
ۥ�Q>���Q>���Q>��Q>�������Q>��ɮ���	�.���f��GT�K�#�9������j�}D5��>��Cz���}tw���#"8�����!�Gw�=�;pH��݁Cz���{tw��ޣ����8��h�~H�����ޣ�>֓֔��5�S�_�hO|]�=9�u�����5ړ_�h�}	�K�5ۻd_3��om�w�vJj��f`{�l'��.�N:�]��tڻd;�w�v�������%�I��K��NG�l'��.�N:]���=�d;y{t�v�������%�M����ӑb��*��nVq�Xw��#ź�F)��4�hްS2G��4�h淏�n������������~�Ѭb7/<�����Y���#-�S[G7vs����G���p4/��ѼpG�G���}yD���G���%����ǿGɿ�ߣ����Q����(�w�{Ŀ��?��]���.��?���G�{H�#�=$������Ŀ��?��C���!�G�{H���Ŀ����!�G�{H���Ŀ����!�G�{H���������G�p���xD�:��q�N؎���<b�;�����#v>��4�1*�Ci�J�P��8�ƨ4�1*�Ci�J�P#v>���<b�;����ΣZ8�¨�0"�Y���@��?$�(��G�d�	vD�?726}`��Wy��|F��/��uF_l
��ꬹ��s����76��_��z�w��o>+|	糒�
�ig�A���:nG���a;�gۑ?s�Ԏ���vd�<�#C���ߩ��ϿS����l#s�ۖ��%���=׶���%��B���*eX(	��rp؎L���v��#��%��JۑWjp؎�/U(��R�Gh\�C���#��``�(���E9nG.���6rQ[�RW�����
���pGd}��#�>�ڶ*C֣��ႎ��pAG���t4_8\��|�pAG���Ɓ�G�q �Y�zD������GӇ��a��v��G�|`��l�p}G�����e
�>�񺾽}�H-Ȩ�f�y���s�@�����&οJA�Y���Farq���E�S�
���]���W���^[0r�#W���\��l̸;�(6վ��P�_����#�9��Z�P�xvܑ�_��1�=�N,��"� ���ſYĥ#X(��'\��9�1���)���+�3sbDM����\�,�|��-��B��������7����_2 �\��S�)�|���O>�픝`��s��� �*s�`d�^�����&���sp��������\�#������W���=��G�o%
���\�#�&� 
���ܹ#��z�si6��K��x`���?rK*N�P�w�H��������ծs=�`�Ю�C���
�X(�:��`�����Ȓ0�G&���?2A�s�P�7����9t��F,��w��v;r(�`������u���2�B���Zأ!t�cJ�x`���u��#ǔJ���PX�s��S
X(ٞcJC%��pj(`�d{�M�����i� z`��d�Ҥx��5{�O��<��́2�S� `G$�3P� `�d{.���;�S�k�ͮ���^>��G��^;2z�rk_X�WKoWR�Fn�� #g��F��3|x#��>�`���� �7MoY��7����ÛDFm3�P.Jm�P.J��� #+��F��%��l�cm�0�f�l��PH3K6A ʤ5K6A��=;����V�#|4�{�6����ZWD���۹&!� �`x����Id��/g�^:0�V=�ȶ�w��U�;F�M�/�Px9������]���1ovM�/���b���ٍܛf_`�0ofN�1������M��*W��4�
r�����R��M��B����&c�I�TA~r�1�&�y�z7`M �f�$n�� ���I܀�¼�Mƴ�Ba��&c`�(�z����R9�5�P�"�F6���9"���G�
�%0;��ON�ضUn�H�(�A�k�CWAi�T��<�n[)�'�@��m�h&p�*`�<�*��i&pzlu�F�%S� {J�.3"�ۑ�P���B����9X(t�/I�{��� 9���@[h�3g0д�;�t�H�lr2#����y����+�r�`�>�x�<R�`G�$������ʙ�y`��T{fD"A�B�B��L�g��5UF�3_��u	US�=3(��9�ΌH�,�*5ȁ{f?P�,�9���	X�[�Z.gٙ�H�?�|�,;3'({�
U��,;�*(��r9�μ
�*��ڄ��r���Z.�șuap��Y�șuap��Y�ș��R��rYD��EZ8��s�#�����¨��͚N	��3���X�4S�oN	�Wmk.�/��m�2�SBT�0��[J����f��g�|	V��S�4�/ά8l�˶M�x�ά8�:X�K�N�\Ө�B�����_���?m7�n:q|�g��l7�nb��3�]����wu��C�`#�|s*6�3��T��G�H��̿���BmBElXg�=\
j*�`�:s�IU�P_��S�k�9����*îy���L�T���L�so�~ 6��� Ľy��ذ�?{3����c�<��|�矟�^�΢�����ǐy�����?���g���<��@���>v����ǟy����3�?{��g���<��A�����k��v��ϗîy��r�5�?�����b�<��8�J�fMl�石�-��sV����*>���Y�����B;�����?�$���g��~;��U�o石����j1��ъ7��3Z�ƝV*f���J�w������?�3��gZb9��U̬�i����3-1���%f��ϴ��z����Y�?�3��gZbf=3-�;�Ǿ�4�
��}�i�
5
�}3-i�`��o.m,�ͥ�O�m�ns)���:����������1~�G@w�5�7�!a�Bi�H�PZAKNI���֘�0`�����A�R�9H�n���9h�m�h����+c��`������ۯ�mQ�~
�@��]Pۢғ�lQ��
v}el�J�W�P2�U����e�e�g�F�W��:�B�ϰ�rz��wXN�?�������1=��H�N�͞cf vr0l�3�P6{��X(���� ,�͞cf������K�Cz��ʚ{%�����wA^�8ױB��bG�E���G�����]�ۅ��Y)!����RB`��r�AJHA
}d���B��,��X(���oJ,��2H	����-����W��r�AJ��c�V�F`��t��	#�Wd����llGh���tXd4����C1Mg�3� �zZ���L�d���`ǫd2"�o�_��F͗D')�-(Td��٫��9X(�/�0z`�!z�K"��B��|I�X(ԫ��;X?A=�����&ɟE�%��(jC`�$E�6*Ĕc����U��r.Z�6*��k�h�Q��^�D5���Azm%6*}"�v��t.�� M�{�%
��'J,�M:8�j���d�;swj�`�Q�b&l[��3��`����I�3�b&숐x    /f���N�ML����齉I/��{1�^��ZSޙ��N�V���N;^����N��{1�
��b&:�q��r����$�
U���>�P�=�^�����L�/��\y�֙كl�c	��j���Nl	�]Zg��,���A��R�;#�P�=wa�
��A�w�� ��BQ��;��3)�[K���]���C� %�swh��5�ޕf���Ɯ���,ۍ9{��X(�9{��:*圽��,'�qoC#N鍎s��~��7��Uzr�Hi'��0�ކF ����� �#¿�� ���R<`ɀps�R<`W���3�,���g��)���g$X�"�,U4X(�����K3��ہ�+gt����lG�8���Xdt�ہ����7�8`���$ض�ڶa���$X(�����b2\aq�S'�3\aq�P(&{�6*�}��,sg�+�Jz�v@�`��wn�
��v@�`�pJn�q
�ʙ�J�S2\� �P�*g�+���S�U��g����"��g�X� ��g�X(����������`��~���J����i�B��y?N~�3����P�~�3��J+��A�<��g <sw�`�b�����}�3w�~

��� b�B���DX(���������`��o�",.��AĀ�
��� b�B��DX(ŞM�}`t̽s�F�i��Y��F�m�B���h�+ب�wv�lT�;��~��қ��̿�������7�W�Q������v��3;�nY�g��m�;(T��^x�xZ�GP�����l�4������l�nJ�xZ�%�[<���ߠ�q�-��_�`���`g�� J񀥊_v,��P�:��Y�*+�A�5� ����(�FѶ:PC�א#gn�3�(99�%��B!�ܣ�X�ϹG�,��=J���չG�#�P�:�(u
W��:~��X� `�K{�Ƣ��*�^΍E��B��ܣf(`��չ�PTU���3����16ο`����6ÂY��Աȝ�2���晢a����y�L+�JA��2� %a�Lam�R���<S4X���<S4X���,	4X(��G�6ب�h�]���a����X,��΀��BI�>����BI�>���BI�>pxr��g���v�EC$
���B$jQJ��Nxf7#x�"��>`I��]l�7��s�]l�7�����~�`��q�$��Ba�>�����ƹH�S�_(����S�P���;j��~�qξ�H���v����tL�a���wZ$�~�m^<
l[{F�,�g_p�"�Bi���H�
��f�9�4��9;͙5O��m���9�F#��_t�'��P�O�-��y �<�z"8���<� �<�g&*,������E��yj����<5T
���<5T
���,6T��n�~�7T
X(՝�J��s��`�dl��� ��8�+Xds�8�+Xdl�aP{�,�3j�`e�wʖ{��T�,�i�>RH����š��c4��o��o	�"��)բC�]��@�(h-R�l��*`]����Cs���|h�����ܚ�������U��ϴf��ʔs�\��zP�y��U��圇�\,�ܗ�U�BQ�}������C
l�X�O����e*�gr��X<��وZ��t�8��1�>�(ag��{��RF`��{��RF`�pO^_�,���K���=y}�7Tc�TE^_��mqO�^|�����/w;uR4w�
R4w%E�h���؅�̋����yQP4X(ܓ��������%��XSά)z	XdT�N�?��d�;�6S�`W�m����mʷs��!���H��$��B�м��X(�9�~��d6s ���
��	��XĜ9�d�93R7`�l�@��;�BE��,gFM�`�:� ��U�y5��μ�� بs^AMlT�9��&����u��kF�� �s�Rl��9�)J9g�!������`�DO}͈2;^��W�2���
�B,��sμ��X(��9P�|`�͐sf�1��m�͐sf�1Xz3䜙uL�PZA�@,����c��R�r4P�m�w�l[�������e<0e�rs�<Yn�܀Zض�9��~
�<��n�:EZ�������z�X��V�k!�c9�L�0"�d�cr�Jg��u�Ҟ������,���<�&1`	�v�ia�;��I��,�Ώg6*�%?�6*4�����������Q��"�� �:`àV���:��#Bә~i�#"�s��:`�H�u�X(<�����2�RB��<�gF;S�l�b�Lq���e�3�Q���b�Lq�Ba��v�8`��ZF;S�PH-ӯ9X(���N��.�p�)Xdɟ%���,���QQ��P�?�
��S�`�p\�`�5��dX{�q�������2ˑ\`��q��h,�A�L/4����3�U6*��˅� R뫊TX(����\��L/T�lT�=�!�J��nd�	,�b���d�Avr�v�F���N�b���D�Av�{�F�O�B)�<��)X(Ş�G;"4�Q;"��k����<�gE:	��r.D��r.D���/{��ٛ�uL�Px�7'�>`���ޜL�m��{U�	�;u\�g�J�"�o�U�$��L�z"X��$�O%ɔx�B��B=|t�B��By7q.D=,�)T5�[u�B��Bysq.D=,�7�B��Bysq.DM��e,�ԕQ5�*c��\����'��+�&ʫ�s!j��P�SW.D��������\��X�M����ʅ�끅�G��֒W�_y�@��_�c'n�+O����j�C�g@6'��<Ǳ9X���R�X2��:�����Y���묣�ޡn�|��{��IX�u�:9��g�P7	RͅB���M��B��u{���;�M��"���ɤXd��+�I)�C��V6'k9�{�M4'k9tk/<'��Bѭ��M��~���<ӥ)X����L��H`�N�b6��+�)X�S���y�ʃi������G���WNJs"��~��<'�9X(�0�IiN�**cO�rR�"������ؓ�����ނB5��G��N�?`�n���������X�M�����:I���B}���������X��P�����U�N^��5�P�P%0�ߕu�Z u�Q�ܾ�[U��ye�a��ۮ�UeL�W�N,�!Tl��y�;���BB����W�Cm�xUY�C��xUY�N],6�Щ́������N����I�<0E��y�J�p����r%<`�]�D�,���>����Rt٧4�Vt\�Wn*�,����G���=�Op%^��42p��W�X(5��J#�����5H�<����r>�4��%p�'�,���DÀm+c�:�0`��جN4X(�q�b��2���W���}U�n[��Bl࿫�V_�e_��v=�BI��e���`�Ō�ki�N���3jO��F�f��,�Z�}�X\y,\W�!��<��Ղn��UM.�˂�+�eA�����U���ʾnQ�|iv��+w21V��L�o�"��r�2+��Ք̬lZ�ph�|��بh�|��بh�|�ԏJ/͞w��E��]6KE��]6KE��]6KE��]6KR�U͞w�,	�jh���fI`�h���fI`�h���X�A�Y�M����s��P`�	��9������l�#��љr�����6�}�X��z6h�	,����r�id����B�Z��|VK�tD�?�3������L9�zNE�g�&������yIW��Hid����v�O�Z�U`�t�<�t�*���$ب�F�J�,U�F�JB��r�[IH��f�$J|����Kj(�Y �<dX����#�0����%�����W�I���"�̔�X�}1W� E�G� `��������(2��j1f�x���2�B��F�ؘ��\}� ؎��\}�l�kmۙ������Qi�����i�������<W~#] ,    ���~�)�����~�)<��A�]�|R�5d~�+ߞoh�#hG�4��+ߞ����Q��+��/l��������[�7h�%!Gѕ�Ha+���>Y��dVZ*�l��lǈ�Ģ�����_��_��k�z>�+�,��
Ej�%��FEyf�������*�P��=h�kϞO��gO���ڳM�s��#��y��A��{��xz�5{b<=��=1�͞O��fO���_��N�c��������X{�<yz�={�4=�=w��͞;M�f����ܳ�Pӳ�������A��4l�<yz�={�4=�=^���CM�f����c����3��S��Y�����{��iz86{�4=�=|����CM��fϢ�G⳧Rӣ�٣��	��!��$m��zz`>{f5=X�=-�� �MϬfO��س�C�#�ٳ����a��Dk�hez�={v4=��=i�z�ޟ6=�=Y��w͞�L��g���_�M���c��	����th��iz6{�4=,�=w�͞�LO�fwn��C�;�Ӈ4gOi��a���Z4�w ٻ����X`M����m����
(��X�F�w���u3�$�79��L�3�.#"�՛�g���:��b�ob���uo�ի��L#X�'{�S�`�Ȟ\��!�h�tN�T�,�f�S�g�B��9�}�l��u�q_m�v���G����'�|���v��+��8�E&���j�W�U�eۖF�GNw��"��bS�Q�L���'Xd2>+U
���VN���X
*�&�	6H2>�&re��k�>���ڼ�R�`�RG�4�my`���zeӤJ���R2�������i�*��a$�xX�l��F�v��.wI�=hT�Oؕ'�f$}�'�H$}���-��J#�[*`����J��9^�p��'��n��[L��N�IkoM��R�Pk
Ф�K�^�����n|�ɦ��ؤ5O696��^�`��_3�<��Q`I����&��� O6u('e
���A.d�,�4ȢM,��"��,��``��Y��j��2%��(cKQD�)ٽE�����<�E(E�I�<ˣX�����������gJv�l[�\�&]`����Ͳ��ս�1�^�CЮs!�e��Ү�1"W�P�]��\�W6Fl
J��ƈM�Bi�َM�X��j�r5���]#靫���g�:W#6}`��ʅ�M�Bi׹��)X(�:2�%�s!� `��w�c䁵k��+�����Jਜ���tnR�-��tnR�_�+�9�J��tNK��Ҿ2��R�`���L�f�`�܂�tnBJ7�eN<�ev�en�9�Y.s3p�P�Y�U3p�P�Y��Q�t�<��X(윧��}eq������]�Xd�,,� �Ef:�2�RK�7(T��t~�%��B�f�a�#�P�Y~X����`݌��e�N�B!�\��lT�[�X�l��9�'�Y��K-�E���|O,��c�<��8�2��g����O�]�c�'�Qi}�c�	ب����䁵>��+{,:��ÒG,��ˮe�K�`��W��%���^f@����Œ��,g� ��
N����ئ�����۵������UQ)K���W";`�,{%�6 ʲW"�`�FYfަ}dX�Po�m�,)�[���Rm��֦n��Ջ�g�3r��z�g�3`��f�&������1�_�����1�����m3��`|���U���	��m�i�F,6�TL���¦glʙxeEDh`�t�<��X(�6�19��~���~�m�c|�=�_�=��JQV�+�!�J?�{���B�yX()z�OY���,�~�����Os&"���cd)ʐ|e9Fh�߶B�1��<�,�Ι�����"b0����[�2c0p�P��1�
UO�[�2c0�P���MPF�<�W&VR,	ɲL��X(�,+)6H3w:)6H���ʒB�~���>+K������S�`�s�u�,�^�w�����]�|%C���L��/ضZ_&V�W2�m+T������J����1�͵����L�˵���2V�˵�N�Bѝ�V�	X(�0�*:y`��w�ʵJ����3���Pc&Vb,�Ƙ�����3�c��븝�\�?앋��%���^'�����s�R7�TVe,蕩�<���-{e��=`�4�\���%p.Nd^A�Psc��rq"�P8'�%�sq"���X>��]�,���u�]�8q�W.N܃C��h5��^M������dF0�ERU&�`�G�o�ʓ4��8Xy��Bb,��I�o�P�c�k�[�
S繦~�Ba�<��X�{%U������m.c���Y��m�4�Z(K����P�:�΃L*��v��sd��`;��y�/�嫏R�2�Px<�"�
��U��������,ϒ���B��,��,ϫ���B��,ɄؙԜ�$R`�NsκHH�m��U��X��(��1�����3cR	l��o.cR	,���3cR	,���3c�遵_k��SN`�Y����rE]d:���B���
R���WP�1��Y�{P䒟a��!1�%�{*�,�Bm��9d[�sr�l�iy���m�<��X�iny���mu��4`��f- h�����E�o\�B�fyQ��TA�yQ��P�Y� ��PضE �8������^�M	e�mu����`�����`���ܦ�,�~�c~����k��s}�J��Q=��Wض�:�;`y�m�;`�Kƶ�_�I��PT~R�,����<�����WK��ɑ�-�.,�=_�z̏N�BI�����P�9�%� ;"�܃|b,�����<�|fռz��N�BI�ܗ�ع���/i�־87��/��w�,tΠ����y��ŕγd�,���;��φ�וw�6GЀke,�Wޭ���ʶ�x�#�
���3{��/{;X:�%,�>�y�3[�BW�]L�����"�:c5]
Sg���do�0u/[���B��l���u礦���S�t��;^�����Թ�-!��B��ֻ�����-p1+�ۅ��9�	)�?F�-a1 �/��|H9���<�!�vbu�Ʀ`�@�}�4 ��F53)_ِ)'�����"bV�P�:/"�+}>W2]V)�;/"�Y�gR&��BI�̇dX(ɟ���z`}����|Hf�m���6������.�~��ʕ�h��ݢ�\Ɉ��<�=s%�]�P�U�Jƻ`���*W2�u
Uc�h�y	)�P�U�E���"[q�I�Z�ܤ�� 1u�QR	,��>J9������)'W�P�U6s�	,�~�͜rr�֒�|�ض�e%��N�ur9B�]��oUh�Pb׉m����s�Ig_�$v�BY�s�6r�u	�2���l�}�E	`l�f�p ���~�Wnҙ7��:+;�� p���p�μ�8 <�B�d��gnpb聑&7���M��mk�efK�灵�љ�S[�v�mYǊ9�S�7`���7}�/:3Ji�`���l�$g��N���!'�Oj�`;���'	���7�O��,'Y1g�(]l��(6�>�d�j��t�����=5�ОY+	��4�4g.)l��7������!���Z�}��(���Vj`��2�?k%���3M1m�^�`
��sU\�?�k�����*�z�Z��/�Y`����0��a�6� e�t�k����������\}�J�2l�L�tع�<�.�o�]P��`�Y`�-�΃Mf�E��xY�̃Mf���ש����gn�Szf�6Qb���uv����,�t��l�6��ޟ�Z���:��̸h���
�2�|��ب,���L����E�ٛM*�F��s;�c��� ٛ�0�P${3
��R8%?�̩Hu���T���N~��&�F�??3���s*rJ�?�"����7�@Μ�D��?Bњ�#(r��șq߃3h��j�b{`&ə5�D��AfB���Y��?���̇���w;����
��?�7����q��ϼ��C؃�s�Й�[�;uj?�7I
v&�mVpr�;���`�y!��gfo�l��=�7�6f՝���o�]K},.�{�q��Y��]K���[��ofK�,�b�N�S?0[�    ��S��X� �>UI���f��~�B��}s����N�?0���웳�X(�Gf5�f�ۜ}�R/���^j�`�R�߿���߿�U�߿�U�߿���Yȴf�
��w��V�,�3��J�g0Ӌ�BI�eZ3�d� �Й3S�~`���9{��J��ۜ,�3�&���sQz�J��>��x)�l��Xd��[�q�Ȕg�N},���Ʃ7�Ю -�Yڔ,�`ߌ6{Q�����tX(G�w����sG�̀��ݹ�	/�Q9��Kkn�f����"��KK���\��P��L�a`�pw�i:l���L���ߪ��&��B��>0M����6/R΅B�}`ڼ,z�>j^
��6��+ܝњ�R��$��YMx�����G)-�P�+��iX�`�|ׄX(���E/�lGֽO��,�l�hMx�m+�{��vDت��eL�"f;��m�S/�0����wMi=0�b���	�aH��֤���^BZ=�|��њ� %�s��,��gv;�,��_7�g����7�aO�%�3�"��CPݽ$��;��<�9���/��|HY��R���)K��ʳ���Q��\�&X(T��p�@�<��}�6$C�F��󨓡`�Py�um��1;�̲N���D��Y�g�B]��q7���^�˃#(T��*?������gB�<�BU�\�3K����s~f $��v��3��`ǋ�3�p`ۢ��4ب0]�*}l[d�����d$�X�3.�,UD�~�w*�l[ŞiJ��V>��h(�m?D�䠢�������ȮV̜[3�v.�z�@m�(�,SD؎T~�)]��-c���Gg�[�0"'V��P���\63r�,��:x�*��Wrw�?13���]{c�&F�3i̽��,���B����m�I��k�^�
�*���͓Fے��pi%�m�㜈fB�mj�[3!�m	�|��X(���V�P3ښ	��ɱ���E�m�!�a Ԝ��:�mqFNDjl4���بj�[�H��ZU��E!�pi%�a�|�fB`;��p
�B������$��hkr�_$��8;W��K`���V+���8+X������d�Cj,2ȉH���͚F��Z���e��9��P8c"�IdM#�"c��i���b��i�� �sNDr��)BvəS�V��һbg-�y��N��n���&:9EF�y:�L�m��,�tX��:m�As�QR`�jy:�L���jy:�N�#"��tV`����8))�m�k&NJ
l۱��*��L���tf⤤�B���ty��E�?MlG�9W�.Y+�է�?0�e=����,����Mi�`�D�٨�,�a�|S8 l[�a�ѱΐQ���AÈy�f&?:A���p"�<�7H�ę�o2&�<�l��~ort�M����������{ 6l��Uf-<6B���C�֬g�@���̎�i����΢��v�j�$�y`U�$63k����Qf-z�4�?y���xgV.�,�v����;WJ,�!�6��i=0E��8��$ZR�e�PYr�{�Tu�ֳ�NF�%�&SS�1��tk��-�΁m�6����=`�M<�$���Ag\4�QS�� ��hf6*<���D���x>F��"�<��A`�����r��Y'K��Kf�]2�S���#��qv2LΌ�&:`;�׎���Gk���c���B�l�4�lo�A�Y�,~�3��E2�?F�9�,� %a�E�l[I�q��lG$㢹��I���}��,2��h�v60H~3"�_����WN�7���HNf?#�F�2���d`�B��h2��o)�l9�5�t1��̜FX�E�޹	�t	$�����u&�d�9ןI#ةS���&��>J���:L���b���H(��j�3��
���h��E���(6����,�d؉�
2y�U`�*�<�dض�ڶ�����i�`cƒy�h#�)جzz1��tY�H�F^�3��6H��7O/~`|��73;�`��*�����ֿ�#%�75��f�&��l���߯���=��;sg�� h�^�Lޏy������JL���8���i����O1���~��閚���qJͼV��H���W��i9��~�u�*
܂"��g�*� ^A�,˹g�)*	�w���f^@���!���>E����py�Xd%�5o�73W�E`;R���(�Q�������Ù�
QȄ����5��d0?.��P���k~\�#�Kf�9�͇�R� 3vSg`������3�Q�A4b7��ɓ�n[r6�.u6f�5���� 	�ܐ�X(�9�:K`|�y��	�x�q�]s)�Q�yyͥ�vDd�4y���Ii�B��d�4�սj�QQ�s�5��s�b/�1znH�E��o��<sC��B�yy�r�`���e����v��s�Rv`;�p9}́�`�%�H�,���kZ���c������/��n�Y�쏓ixf����P���V�,2:�I���H3�GS����[����I�C�疣��BI��rض8{�f��c�������P`�R���\���I�)�����Z�	��W�紛<|3�$�_\������ќ�#�H��(���`��y�mP��$Dڀ[ШJ`���yN��/��K��C��ZG�����i�'�7��`�B^ُ�H�Q���Hب�H�$lTH$����u��X��-���B��a�㧏���Tֵ�sY� r"�v8
!���6`u�W�G�ӨLr�ijL��͌t��~u��F���my��<�Q�mY���Q)��I��+��QI�Bȷ�]����˖G��
��ң������\4S�
�㪆�o�L�~���$��̨����w�;�䈚�`�p: �����U��t6*@���cF_��I3���-ؙD���P)ؙ4��ĆJ�؎Hw�.�������=����H+�+I���*�h�MmfEBi`;��9�0X䇸�W^���H����֣Ń�zH�����`���)@v�;�z ˍ�i�Y��ؙ|��!��FuU}���?�]�`�:���t��v�Q�FUW�-��Mxu��b6�;+Z�eTe�ٝ�K���2�����c���F5��^�u���x�QM����Kݙ���l�0jn�w��	6��0jn� w��	���~k_�Vw�(t���ku�	9���#*��9�,�/A;�_�v�9��_���~�kug��~�֯X����/�߯�ւ8?��(,�C���!���N�����IV�]�!C'��D.�᝿�G�Rtw����w�A�,7v�.���x�,���Q09�uzg�_�FuU����Ε�`�:V�jT�Q�x��<�>6��*�M;���<|�؎n;�RY��F$���܁w�>�~D��36��H4����od�Jx��#�����mG_;�4��,}X�?yu��U�֟��,qT��όww��l�sf��x��;T����Yyp-ب��=����g&�;������ׂ�J��H������1+��T)ؘ�ub���_��48���VTؘ�Fv+�lTJ#'%�6*��7�V���Vv�U���VU���VU���VU�͋V��t��Zz[V��������/�oV�{ߵs�=�״|����ov���-I�?��w���wR��ʇ-���m*����,�|ߺ�b�wZ<��nr�/QY {X��/ �˵�2��-�׋ $��v�O|��}=����?��70^����mE��_�`�����C�H���O�������>��\:�ː�����~�p�˓4Ǻ���?l�;�������&�E۷��/p��4����wQ���͵���o���:�O�Ko����\`��]���~�~�ߗ���7�����;=�z��/�Cz��M�vr�7������G���O돞��|���'���������7K��C<�Ux���~����^k��M��z��U�գ��u
��z�(��vQhʻ�%��    =�X_4^3z���{Aʭh|����[�Q�l���y�T��]�ے�G�Z�s�UǸ����]���Xiz���1x11�Ϲ�[��%��j������ū���j�PրW5<Y���zN�0��>�'�ֹp(�ѱ<�t#t���}����;�~����c=!Z��s�Y��XZ�2�~�޺��}{�#�):��ر
`�-��wZ`}�>�W�`�s��]ȼu3�\~��^�o��X<�������O�������|?�G�>e��i������-,�vǻ.������xN�u�_�WJ������r��߇���/>�}��.����mk�����M�����?ή���c��ʡ�.�~;�w}��{��_�M�â��z{������=~~t����t���m�m1������n6��3���P7��iz�];Ӹ�{e�����>��|�p�`M� �9�uHO�뾿��c��߽>�@�u�.�q��\k��yǝ�m����2�)��4���5�$��������Y����{��f�����l�	���F��S0����<+��z21 �s)&`��gN�+����xo��\�x����y�w��g_��.�:D�0���]�qzW�n8O��;׿��_��r��g��{���8���iHV����0��P^	b-�Xoq����������"��n=��3o1�X�7������~N��v_�2����!��I�j4�wy�\G���?�:���������a�������u{F�D���P��vj�����9�ޡ�^8�mВ�ab��Qj��g��S�	� �痜y���	X<{��/�v;��7թ��_��U�s�1��ã��9� ��6���E��c�X���z̗8M�g9Rvޟ�S�����������{+�+��,0>�yO=��x/�?��:���|7ve�s��tcه�f2^�G��F�\}Tf��`5ܯ��k�+ٞ!���T*%�*ޡ>�{����m1Jc/�)�?���Ϫ�'G���:Q/���~���9,wZ[��hs�LT�U:Ւ�䜯oS=��U����_��W~߳;Vx����Ղ?������]��!N�٧l��m?9�6Z���J�����-�'����ڼ~%�4���S9���2�n���Խ�w_��Ƶ1����?�����e�[�T��.7�q���*���C�G�%?����*M�~�\`��W��iY���}~��ae�y�M޲���������o��
�����oED7}~��_���6X��w� ��v9+�ǚV�=�^ue��p3x��U�5��߷�/�v��\��������j1u w��^E�������������_L��/�Rc��~/
]�oi����l�H�T�iB�����Ę׫X������{z���ۮ�����Y���~׻W����e�5����6���R����jx��S�<�(��۱�R�X-L����[Y��n�8O�ܤ�[����4���Ӳ�����b'a���I�5I<�w�_��k���ޞb1��V`��^��`�{���_�}�i���ߜN��%��K�ꓧ����)X����;�/�e>o7J{�����}���Ӣ�5~g�x�w	�ٙ�o:l�p���&��PW�;��?�<��w��o`:����^��9��KW��6W�U6sM�,�_`���������73*�O�h�,���+���e?ǻ��=��3Pk��&x�s������_����j����=�����4Ow�\��c������=�J-�;�WUX�wX��~?|z�Ic������<1�&N��n|^1ni��yd�����k��r�5s��*���_��p瘟��h��c���S���?�����mK��u��ogo[%{.�}�;e�����[� �^�g�%�z����\����������%vc�R����bI�w�����8���_�n~������
|��g�ݸ��d�v�j�\��Һӳ��ºs=�X%���!���;��_����8��7�<��8��l�(�xN�_�"�V�?WY�w��]5����Yݹ&l�jV������������Y�k��v���le�Ύ)���/0���zQ���I�^�������3$���������$p�'}�p�g�����{<�x�R�^�}X�w+ï�����0�8���dҽ�h��s��N�o��b���Y6v(\�n�^�b��a=�5�2�ev���	kFOO�H@˵3E]����.��L�Q��ԃ��4�����E��w-;�Cr�i%o����y��P��oH���2��3�7껇�����ãU�ט��X�����6����\��,�#���V��뙂�T�s�Ywo�P��*L����-�>��3��U�k������N����)2��GX��d������׬)����z������^��"ȵ'j<c^G�����`�s��8�{�[	��~i`+a�'�_�o=d\��� �3�·���];/UX[��+qkw���
e9�A}���XWs��e���J�L__ |N�\9�;�����{���s��Gs��gM���l��g�����wm��x�8C�*�Kꏵv���6����k��������|��������3o�?�7/�h;�����9pX(�����S~=�W`YMw\��v�X�YW������ͽ���Ur�Z���>�|�U�\�	��"�p���}��s��k���WC��mXԻ��)ܶ��]�s���m��J�y�+~�uk�������:��^�~��-���e�׻0��V�t-[/�[�v��m��:���&�U��̬I�o�Ǌ�����ަB
�k����{��ũ�l?�wn����r�59�@�`V\�J����/;{��p��U�����)�?Z�]��زpi���ol�{����
k��o��6����2����������h�g{�g����i�}�ޑ��{�g~�d�6c�������궯���^���	��Vf���۳��ln�������x���e���1�A,�s�w������KڼJ���y��ʇc�Ͳ��y�5���-x8�v�s��F���ǚ/��/]��}��X7c�}�k�Ŝk�d�����.�w�8���aͽ�k��_M�]�IbM�Q#;Vk�kֻ�w$חEη��7}��J.���Z�������C�'��*��$��*��{��*=�a�2(B�~oέw`� �A�Gh�����%�&����W��k-c͠�u��Yz���7�}��6��SSs��u��uKs���6�+�����*rg�Z�EP�T��a?�9�� {,�k��j���;'F8�y�*�U�k����s��>X<�=��fk��~?��ZӄW����0�|�⫏��]o�}��X��̬Su�oߥآ�WYRx����o9tĿ���}�����Cy~˽��)9oS[��X�7��Z�[2���T̺��t�?,�s�N�sr�A���>�r ���A�������~��,��p��+�T����Nx0��v)�؃��4��]Ǉ����y���V�{�k��v"g��/w|��'��i<�C�o��w�߂�s�=��q����_�!yG[^xZs"��i� ����[d�ݹ�$i�ݹ��~��V*����J\����t�3�y��������~���F����kn��O�J���^7�^���#�7���m�����|��2����ߞ�߿8k_��m_����Z�4~�I,�;�
v��b����c�;߇@V��Y�w��B�𮟨Y+�����V�/�K�|���x��8_��J��ff/x�}�cc,z��d�<��׋ߋ`�ε^��|50Oz_��>H�>�Zo�\�x�U���[����[�v�^~���x_���%5����{����C�g.oV\���r��ߧS���Z}u�*�^_��C[�~�ݢ��y�����������YYu�r������!�����c������|��.u}/�Z]�����]��Z9�R�z)�����r�ߘ׺������X����~_�2��{�������������6���k����[��~�uf~/��6��������Br�i:É���,�Z�����t^�7�    Wy�<ތ�O����Z�S�q�p�/Y�7����Y�x\/���hG׿��ڃ�S�[P�2����:��������^������;��{���Ӌ�WBjIq�����\kc�>}��_Ry[�׼�r�{�x���;�8r�E��a�E��������}�F�l�,����m'}�y'k�z-�ӹ���*&��j3Ŀ�3��F����}zi�����k�])��$2W�s}m������"Ǻ�k�$�9>�q}/���x��b��2�5u�%�b��׿��z����1o/��Ν�4?�9�T����Q_cw�~1�����|���֐��5֫��wE�z��� ׻�o{�`���|�-���|��8޷�����/8�I��z�9���{O��WH�Y�:~��ۍW5 ��k/���������;�8o)[����o�����p�/�\`�5k���U�/��^p�o^~������^�֫���6��������K/�߷�� q����z������t����֋U�_ O�k������ܿw��������T,��o�^���x����`��]���o?|��}��~�I|�����}��.K���0�g������]�����-�uU���4��b��K��������ic�z!b��d��j��=w�������n����M�����}�������6�7_o�5�}n����sww��޸�m/F><$y[��q_�5V}��E$}�y]u�[�2�ɗ�����wO�z~���U? ��#yК��q߸���Ї��4t�G���_�]��m��U��y9L�a��k�������
 �������b�hn�B���>6���ϸ�ۘ�Cs������xor����f���ߠ�S�Ұ��#G�q��5�Eh����s�}n�5}�>�kGg|es��'ƣ�����_c8e�:�R���g#ߜ̾�����C�`� X?K>o�gj���ㅐuS'��,j���!L�%��wwj;	�G��v�������?�O<k��j�����5�e�ֽ��ѿ�1?H3���C^��<�������I�i����u^�$_��h�M?�1��?��䅣7���l�����hy����.,�gܿQ׌�G�?�)0���޿�����*�ڷ��so �^��xE�x� t��XB��ĺ4��:���rs��Գ�j���)��5�1�)�v~��kX�Y��X.��7C�������oXyB���\a����*��!�[|���}'�K����p�%�����ă��n���ߺ#���g���mN��Y��=Y����r"�ϛz�!j->�5oKt~�Z���+�y��eZ���-G�qG�{��w����S�;e��U�W\*�;�����lts�Y�'��`qz|�u����;�{��������&CQ��b�9�wИ^�����v�k8�}#�d�ߺ:�&n�����s)�0vGՁ��sh����W8���o���~y7|������o�y�z������^9��o�;�f�&�w.}nܛ ��Kޯ�M3|���fKb��Mu�����i��=<{��ȣ}���NLg��v������ϛ�������q�|�u ����늪`�/n����W�س��¬�Fz����+;�1�c�-ּ��0����[t���[��l��>82���ýў���~�G��=�7����h<�*6�i=ۃ�S�0�6eC5n�{��=+���z�0o\0��ѝh��?ݽ皔�%x陻�#�'��u%�~��F�w>�K��U����1=�M����h{���:�}Ή��^�ߍ�Wy����E5:������~ �y��3���ym�l��RΛ٧��c���\�+��q�{�o;V����Γ��o{��}{�������\g��D�ͤ�2��o�zk);ߙ:��7�߆��kc�#��U,�v�e��L��_�ӏ���7p��o<v]��u�t~3`�)�?t�޼��Qx��o:c+Z߇���gE��[��{c� ��Q�����s��_�לE9,��m���7O}��5�v���H�hB�Qx=_����ޯOa����n�q��K����9?��e��H��4����/8�u��1�Bx��L1�y����E�|yÍ�5�=�6�=��6�\����6���b�{ �w�����n|1G�^�,M�tG�~�����,Bܑ7sL�w�8$�~��e�y�w�N�g��n���;~����o�f�?V�����}��g��=�R|�}�Z|����ms��}��N��;i�.��o�؀?��۶����D� �n�3��?Ĺ���L���p������L��D�w��6O��(�ݿ���W�G�\韗p��#p��[��m�����JV�g��߉�����?^���߮�ݿ��v�vO���3m�gg�`�;�4c��ݟ��x����m��?.����n�?'�q��G)w��u�?o9�㔻�����r�?{�?B���V�?D��r;����?H�������	���v�罊Ty�mO���?̼���?/����v���y��������E�O�m�O��B���v���Y��Ǯw�����*�?"���_�v��v�ݿJ��,����W����m���?o�������K�����yw��k�����m����(�@�n�-��F�?ػ��������?��������c�?����������?\������t�P��ǧg|���X���7�?���n����`$tǃ�x`T���X\�c�G�\����ix$������mz�u��ཁ���t�����sO]�ܭH�R��=b�"��E�\B��C��W���}��eԗ��Sc�䍖o�l��,qF �Rr�e��#�Wfy����{�4���L�p��`� ��~ }�2&���%nVɝ�+�p	��A��kN�	����j"�	�F���i8�	�FF��i<�	����i@�	�fL��i��	��L��i��	��L��i��	�& ��i�	�&Q��i�	�fQ���h��	Y&J���e��	Yf랑�e��	Y�L���eN�	Y�.���e��		�����0fB���g&$��|fB���g&$��|fB�1�g&$��zfB��xg&$�zfB�ɮg&$X�qfB�7�����g&$x��q�i�뭮g��zS�Ia���V��ݟ�`o��ό���̸`��>3.ػkό�V�3キ93.�"�3キ93.�-�3.�[�ό����3�r�;=�r�O�̸\�$>3��M�3)�7���`�ʙ�֫���۔ό����̤�ֱ��a-˙I��g93�Φ�{�d��ػ7�{���3c��ٞ�w�\Ό�[�rf��+~m�\�L
l�˙�w�]�L
l�˙I�-{9Xt�ݟ��ް}fRb�13)��g&%��3�_�����A;m�/����3��͌���3�_P�����IJ��g&%F��Ggێ�+)�:g%%�0ତ�V�x�`�����)�JJ�|g%%�n��;=+�Qϊ�����;�Ί��H��;�0Ί�C
�����;K�Ί��*��;�A+��r����8+��j���[9rVR`�1�J
l��YI�->:+)�ug%�鬤��$��U�J
�0i%�6鬤��V�3���Ni�?�UZ���V�3���l��Y��h�V��>g�?[sV���g�?�Z���V���Fg�?[�qVRdLΊ�F�⯭�:+��j+�]�ݼ�ڻh�Fx��>��x[�qF��ϑ8#��'G���qF��Ox8#��G<�o��3Έ��������[�L�3�|���>;��x��q�Nj��7��0`��x�ό�0b��x�ao1�-|�ę�>h��X�Ebg�z,=3�ce虱�Cό�Xvf��z�3c=�:�뱢��X�>g�z�`;3�c�ؙɮ�a��OdK3�6��lۊ�3�m[zf�mC�L�mq��~-�<+�}�J���笼��g�;��DSˀ�J4��DS������"��Oo,?+��:��2?����Oo�>+��R��2?���DS���J4����xwKrΎwG����-a8;�    �Ύw���xw�wΎwG��3?��9;�%����v��3?��p#m�/���o�k��dw��~v�;��?;��R����y���?�2���Κ���,18'�R��;C�=��`oO�3��������=�~�՞|?h�{`{�=�{=�>!��d��Y?�>h�d�0_O�/��O�+P�'��֓�
X뉿d�퉿�6q��w�W�*ąʅ�B���L=OB�7��B>c���b��@+y3�/�\���й0rapa����ʅŅ��'���� \P.��������T������'===���IOEOOz*zz�Sn������q!=�F�8}�q!=�΅���Ӛ\HOkq!=�ͅ�����FO��6z����S����*=m�T�i��JO=Uz����FO��6zZ�i����vzZ�i����vzZ�i����vzZ�i����vzZ�i����vz���AO[z:�iKO=m�頧-=%s�o� ��T�h�W*{+��Jeo��Y�%���~k�ϊ�\���~K�ϊ�l���~K�ϊ�z���^�+���g%������2�Wr��ϊ�"���n+��J.c%�Y��V�_n�Y��V���+�ϊo���T�։����j�RY#�Z���$��o��Y����o��Y��(�yz�Εw<�%�g��[�wv��e�g'W�*���ʖC��\�R��SY[�|vV->;��%�g�Ҷ��TږB��J�r�Si[}v*mˢ�N�mi��ɵ�+���d����Nnm��ɭ�e>;����g�2����T�V8[q���#����Ǧ��$�Z	mb��_r+��K��K�c����},�<;���VC�M��Mr�|�+�b����'Ve[-���?���lkw���Ǿ�жt0m�?�m���Bi���o+�ώ}[Xk9�_���c�V�Z���O��j�c�V�[K���{�����+�H�ث��g�^�R>;��`��\��m{=�WK@ω�Zh|N�����Z�}N�����Zf{N����sb��jO���sb��Zǘ��{�b���O�������?�����N��O��ԉ�q�Ɖ�q�Ɖ}q�Ɖ}q�Ɖ}q�Ɖ}p*Ɖ=p�Im�A'�'a��Ga���]���]���]��W�8���xq_9��$�r��I|�Ћ��ʩ'�����8����8����8��Ğ8���>8��� ��ڟ�NjN�8��9/��爋�ڟNjN8������pR�sj�I-oi�9��9(ख礀���'�C6N�7�ll8A�͋�?`}p��n$v������}A��d��36�K���1a�쌍)V�m_����	˯�v_3V���2��R����.b���KC+��X\qv�r�.��4���%@���4�✬�pv�ɺ�g���pz�ɺ�g���p~�ɺ"��uN�8Y���u��8�%8D�$����u;Ԗ'��j���!t�[p��Ina�=���B.saqa�����y/?��d.��Ņ��=��ʷK�X5�B��*�X7���T�N�:T�OաJ}�U�Pu�~F�=�R��C��$Z��'��P�>�W�*�I�:T�O"֡J}�Uꓘu�R��C��d�P�>������=ԠO&�}2{5��{�A���C�dj�'3��ۏ�5�9|�A�L�C�dj�'��P�>�Ǉy�$h[���頧	ۖ��Bz:�i���z�d�V��B�v��}����|��k��Z������&�[���I�7 �2@�J�l�/d����P _HO=MZp��'y���$��,�Ijp��'����$�R},�I�p��'��y���nz����_HO7=M�n��'I�A���z�4�
q_HO=M"bP�/����&5������pn��-/%ұ�����e~�f�y���Y���j�C��Z�P~�V�y��ZY�������p��)~�V���Z�)�V+==�4^���+?_�|�����,�%^e�W,�*K�b�WY�K���X�U�x����+�x�%^�ī,�%^e�W,�*K�b�WY�K���X�U�x����+�x�%^�ī,�%^e�W,����K��%^��[Y�K��X*beeEW��ʊ����]+++�"VVVtE����XYY�����+beeEW��ʊ����]+++�"VVVtE����XYY�+��]��[Y�Ѵ��+�ieEWD�ʊ����]M++�"�VVtE4���hZY�Ѵ��+�ieEWD�ʊ����]M++�"�VKO����S�i���hZ-=%�VKO����S�TOOy�S==%�VOOy�S==% WOO	���Sp��� \==�w������78b}��3�����h(��0�h<��2�����h(��0�h<��2�����h(��0�h<��2�����h����#�)�FzJ:�����h���#�)�FzJ:�"�R�<�#J!�(��C:�"�R�<�����tD)D��yHG4�S����t��W���WV�w�\X\ع��pr����W���W���W���W��������S���~���~���~���~���~���~���~���~�ŭn�ŭn�ŭn�ŭn�ŭn�ŭn��#l1��[��0�#,���#l1��[��0��(̣�<
�h1��<Ẓ���!��b�y��Ga-�Q�GK��ȓZ�F�Ԓ'5�<��'��I�<�%Oj�I-yR#O�ɍ��so۸�-����p�=w�q�z�\���ܹƝ�s�;�s�w���5�\ϝkܹ��p�=��>{�g�}��φ��q����>�3�D5�G�j̏�՘(�1?�PTc~D�����FQ�����#*E5�gd�jx����&��-�LT�[F�����6Q�r&�D5ʙ��(g"OT���>Q�r&E5ʙ(�(g"QT���FQ�r&"E5ʙ��(g"ST���NQ�r&BEuʙ(�)g"UT���VQ�r&bEu̴�L;f��:f��:f�:f�:f	��5Ӕ3�r&"Fuʙ��)g"cT����Q�r&BFuʙ(�)g"]T�z�vQ��%�Eu���թ^"_T'��~Q�r&FuBt���H�	��0��#bT'DGŨ~���蟂o4��Ĳn�� |C�7�P��7T|��� |C�7�P��7T|��� |C�7�P��7T|����J�Vg!�E�YgQq�YT��pg!�E�7�P��7T|��� |C�7�P��7T|��� |C�7�P��7T|��� |C�7���
�P��o����7T|C�*����P���o(|C�7���
�P��o����7T|C�*����P���o(|C�7���
�PY�(��,
g��,
g��,
g��,
g��,
g��,
gѲ�P�^H�YbhYb(�ZJĢDl)k�w�Ǒ��Enђ[Լ���'�h���h���h���h���n[��}G�m���n[춰��-��n�D	�E�o1�[�0�C.�ŐCn1�[�0�C.�ŐCn1�[�0�C.�Ő��<���Cn1�!�rÐ[�a�-հ��jXT�E5�I�E�XTâZ,�aQ-հ��j7DŢ�cQ�걨�E�XTâz,�aQ=հ�����=�~{�o#����F��	����S7
➂�Q�č��ǲ��c����e��Ѝ�g�x�ST7�Ꞣ�QT�Ս����n�=Eu���)�EuOQ�(�{��FQ�ST7����F��Se7�잢�QT�Ս����n�=Eu���q}�����/bu�E�����#��"jlu�E��긋��qd��.��V�]D�����&[�܇��)�"�lu�Ed�긋��qbk�F���;D���w��I���a>�'�[��_�Y�!h�cAh�cah�c�h�c�h�c�h�c�h�ci��ۏ�'�!(u�!,u�!0u�!4u�!8u�!<u�!@u�!Du�!Hu�!Lu�!Pu�%B�P�:��P�:��P�:�P��+b�ZC�ZG�Nbx����Y��,~����G��,~����G�,~����G�,~¡N�
�:	J0�$(�p���ġN��:	    JP�8aq�S�ơ���'Z�v/�\�\X����sas���M2O�4
�iD{�Ө�4����i0O���`�F���<�rO�y��4�=�i�{�Ө�4����i0OC'�`�O��<�@�y@��4��i��0
4���h0OC)�`�S��<�@�yP��4��iP�әy:���h0OCР"N@��8<*� 4ȬC� �R@��:�H�^d�Ľ�"5�{Fj��!� �D�A��@�0�a.,�\`���4s`j��'и���&q/�M�^�Ľ0
4�{�h�B)�$�S�IyN�&�m@���!hR�U�IyV�&�x`�$�h��W�I2^�&�x ���!h�{Q�I�F�&�w ���Q�k�."���D'��yD(��yD)��yD*��yD+��yDR��Ԏ�F��Q�&EcT5����h�FW��5DX��5DY��5Dƫɤ��W�I!��.J^-&]��Ẕhw��c�j1Ǣ��b�E����~W�9�s,*-�Td8ZL��n��0�h1?���b~Dj�����F��,b-j��m���"�Ѫ;q�ZN��h�5�{!΁��^�9p�������&��� �&�&�#���zLn`r��k��*M��(�5�H�5�h�5��3�젘�H�b6�#����4XK�H��> $�vӏ��ͬ}�
7n\����񇑤A�h��Y�=�g��h���ۣAzp�ƺ���Y֟Ǻa/���N@c�����	�p��h2�d�䶄Ȣ�m	�E�۲r[&�%�MnK(-�ܖ`Z4�-�hr[j�d�Cj�dԃj�$]�E�t5�M���Z4IW�k�$]�E��`�f��#=%�E��5�M��@[4�_Cm�$�E�t5�M�ՀY4�NCf�$;�E��4lM���Y4�NCg�$;�Es������ТIvB�漡3=%;�E��4�M��PZ4�N�U�Ģ�U�Ģ"��Ģ���Ģ"��\�C��Hf5��hf5�_#��$�jVsݘ����F��I���5�䞓�3�UMr�hW5�=#^�$��zU��3(Mrϰ<4�=��<7�&��7��E4�VK�	{��^����j+���&q
�A��)�-�y��䂇0�-m�C�[�L��!��'�a3���f:D��t��K����6�!/m�CD^�L������yi��E�M���6n<�/m�x�_��|�~i��E��M��69_P�L��ô���ch3-C��fZ��ʹ��L�i`�6�2*3m�edf�L��̴���i��Fi�Cv���i�f:d�u�0��6�!;��L�t�$�����.x)b !P� B���@1�"b E � �@�1�(b !P� B���@1�"b E � �@�1�(b !P� B���@1�"b e����'��G��'�P����M�b��B/)�%
����(ύ��Fv�W(v�_x%	�ͭd�u?�n� ��������~7��<�<��$���^�,*�{-���Ȣ���"��_�,*|-����Ȣ���"��_�,*L$-��@��ȢBE�"�
I�,*\$-�����ȢBF�"�
I�,*l$-�����ȢBG�"�
I��>L-Ҫ@�H�v
�E�̀yV8Z�Yh�g�4�E�ԀyVXZ�Y�h�g�6�E�܀yVxZ�Yh�g�8�E��yV�Z�Y�h����:�-�u�ZD�@���֡Pi��&�"Z�M�E��@�h:��:x-�u�ZD�����֡]i����"Z�w�E��J�h��:�+-�u�ZD����!#h��F�"Z���E�A�h:��:x-�u�ZD� ���!$h��H����D�E����W��:�g-<_���D눟���Q?k�#�&ZG��}�g��&|G�M��Z�Քh��YM�Z�Ք���YM�Z��7:hmVS"��&!�Z��8�	mVS�&ChB���&�I����fy%�	m�W��fy%�	m
��&�Y�
oB�J?�	m*�'��QANh��&F:�M�
uB��61*�	mbT��Ĩ�'��QAOh��&F>�M�
�N���61*umbTD��Ĩ�Ե�Q��k��S�&FE��M��R]���61*ZumbT���Ĩ�յ�Q��k��W�&FE��M��b]W�<�61*|mbT �Ĩ���QAvh����&FڡM�
P�$�61*L@mbT��������"t��"t���"t���"t���"t���"t����t����t����t����tn1��w��.�l,����?��ss�X6
}E�/��B_(���P�+
}��W�B��(�B_Q�����
}E�/��B_(���P�+
}��W�B��(�B���\���l|��i���l4���_h����+~��W4�Bïh���_�����~E�/4���_h����+~��W4�Bïh���_�����~E�/4���_h����J*PI�TT�B�P&eR��ٿ"��E�/d���_��ٿ��+�!�Wd�B������_��ٿB����� U*�ʂT��*R�B���V�� U*�ʂT��*R�B�,H�
�� U*�ʂT��*R�B�,H���x��*R�B�,H�
�� U*�ʂT��*R�Wrar!=���IO�0z�S<����aB�,H�
�� U*�ʂT��*R�B�,H�
�� U*�ʂT��*R�B�,H�
�� U*�ʂT��*R�B�,H�
�� U*�ʂT��*R�B�,H�
�� U*�ʂT��*R�B�,H�
�� U*�ʂT��*���D�[(y%o��U����WQ�J^E�[(y%o��U����WQ�J^E�[(y%o��U����WQ�J^E�[(y%o��U����WQ�J^E�[(y%o��U����WQ�J^E�[(y%o��U����WQ�J^E�[(y%o��U����WQ�J^E�[(y%o��U����WQ�J^�Q�6�F��PPjCAm��Q�6�F��PPjCAm��Q�6�F��PPjCAm��Q�6�F��Ǡ6
Ԇ��(P
j�@m(�����6
Ԇ��(P
j�@m(�����6
ԆB�(�B�(�
Y� k(d�����5
��B�(�
Y� k(d�����5
��B�(�
Y� k(d���aǛ��)!)�����6
Ԇ��(P
j�@m(�����6
Ԇ��(P
j�@m(�����6
Ԇ��(P
j�@m(�����6
Ԇ��(P
H� i( ����4
����(�
7��f(܌���p3
n���(�
7��f(܌���p3
n���(�
7��f(܌���p3
n���(�
7��f(܌���p3
n���(�
7��f(܌���p3
n���(�
7��f(܌����9�"g,䌊���3*r�BΨ�9�"g,䌊���3*r�BΨ�9�"g,䌊���3*r�BΨ�9�"g,䌊���3*r�BΨ�9�"g,��u�=M|Aߨ�}��o,􍊾��7*��Bߨ�}��o,􍊾��7*��Bߨ�}��o,􍊾��7*��Bߨ�}��o,􍊾��7*��Bߨ�}��o,􍊾��7*��Bߨ�}��o,􍊾��7*��Bߨ�}��o,􍊾��7*��Bߨ�}��o,􍊾��7*��Bߨ�}��o,􍊾��7*��Bߨ�J
^��+)x%
����(���W��J
^��+)x%
����(���W��J
^�"�,����^*��Bx� N
ĉem�@Op`�(̓�y�0O
��<)�'
�`�(̓�y�0O
��<)�'
�`�X֖�41
�A) (
���(���@P
�A) (�T���*R�B��HU��un�@O� �( ����T
��R)@*
H� �( ����T
��"�-$��d���*��B2�Hfɬ"�-$��d���*��������l�N��,�-
����(��ߢ�[
|��o)�-
����(��ߢHy)�"�-�������*R�BʫHy)�"�-�������*R�BʫHy)�"�-�������*R�BʫHy)�"�-�������*R�BʫHy)�"�    -�������*R�BʫHy)�"�-�������*R�Bʫ`u��=�Y`u�N��Q�:VG��X�S`u�N��Q��bVQ��YE1[(fOA�Q$���V��ZEB[Hh	m!�U$���V��ZEB[Hh	m!�U$���V��ZEB[Hh	m!�U$���V��ZEB[Hh	m!�U$���V��ZEB[Hh�Q3R4���V���ZES[hjMm��U4���V���Z�T �dR�LR�I2IA&�$�T �dR�LRI!I!$�$��T�BRAHRI!I!$�$��T�BRAHRI!I!$�$��T�BRAHRI!I!$�$��T�BRAHRI!�j�\��q� �dR�LR�I2IA&�$�T �dR�LR�I2I!�$��S�xOA�QH<����\�zr�??h�ͣ�y
4���)�<
��@�(h�ͣ�y
4���)�<
��@�($��ģ�x
�"�.�Њ��C+r�B�ȡ9�"�.�Њ��C+r�B�ȡ9�"�.�Њ��C+r�B�ȡ9�"�.�Њ��C+r�B�ȡ9�"�.�Њ��C+r�B�(c
e���)�1�2�P�(ʘB�(c
e���)�1�2�P�(ʘB�(c
e���)�1�h��(��B���V
ъ"Z)D+�h��(��B��HD��" -�� ��Zgp�fָ�{1�݌7U&���Q0?�G��P��Ca~���Q0?�G��P��Ca~���Q0?�G��P��Ca~���Q0?�G��P8o�M��X7�V`��[�uS�n�M��X7�V`��[�uS�n�M��X7�V`��[AqS(n�M��7��VP��[AqS(n�M��7��VP��[��f%��Bq+(n
ŭ��)܃�{�p
��=(�
���(܃�{�p
��=(�
���(܃�{�p
��=(�
���(܃�{�p
��=(�
���(܃�{�p
��=(�
���(܃�{�p
��=(�
���(܃�{�p
�rVGqV�rVGqV�rVGqV�rVGqV�rVGqV�rVGqV�rVGqV�rVGqV�x) /
� �(��� ^
��x) /
� �(��� ^
��x) /
� �(��� ^
��x) /
� �('�'�(��� ^
��x) /
� �(���nխ��-T���P�*��Bu��nխ��-T���P�*���;$��UT���VQ��[r��&!�Ud��W9ܥ8�E9ܥ�$��B���[u��n-ԭ
���(X��`A
,��)� 
���(��Bu�pB
N��	)8!
'���(����pB
N��	)8!
'���(����pBj�.~N��	)8!
'���(����pB
N��	)8!
'���(����pB
N��	)8!
'���(����pB
N��	)8!
'���(����pB
N��	)8!
'���(�����k�R��R_Jw������o���k���qp(�R0Bmt��V�х6Z9k��6X�+�`E
���)�"
V���(X�+�`E
���)�"
V���(X�+�`E
���)�"
V���(X�+�`Ej���+�`E
���)�"
V���(X�+�`E�X�3�m~���Y�\�3��s�k��^�\߿�3^��k��K<-�#��۷�Ox��v�0@������M�����(�a�.�����W��5�K���Ĵ�{��1W� q�e�毕��[���{����ߩ���*����1���u��kC��}���np��z��c-�}#-|(�Zz?��������>�Z� G���W��iz(h��z����[�쬫.\�
�xq���ܟ|�n��j��h����k������������^_7����K����
?��H������WIp�C^��m?ch�Ua�gx��t�]ނ��U����Zwo���n������}�{��4i�8�Wu?���<���}Yr0�d�7��yy�̞�L��~��t�7�f~�x��٭��ޒ0y��ߛ���c��|p�E��\�#�K�ǉ^ď���7#{�����0�7k�%3yf��t��#�w�����\���붞�$}�6{�v��.���\��V����L`n�v<_�ާ����?��>M�`Ķ��~���d�7�lp|���IN����Qn|w��v��ћ�?�>m����{�}����Zd�z���Zq��/?�}���Y�3��m{�Ҿ����ץl�\�4k�=�#�.V�tl/��/x�ۛ,��9�=��z����n��oB��gz{F�Cͤ{�Ý��1�x��J�o��q����5���t�ϱ�7ҏ>�}��ö"�;>o�N.��e�ȴ��r�i�������a:���u"��b��i��sS���'��*l�ʐ�a�1����}{M�x�������� ��M����]-[m'�^����4�����H����x.<�4�o�͎^�l���iH�@�}`������Q�b!]�.1�?�����^9~E�=�3���75�i�����&����~_���Z�~�m1��<&�o�;���2��7�){�����i�F�x]5;�h7����~?�e�ԭ���?�+<v�ŝ
��g�o�}i�7�;G�������KE���h��<:�ï�t�_�:b�왦�N��~�y���7*���k�.��I��1��f�������/��c�)�(���AKU�H'�e�2̔���n�ش}.�Z�o��$;7����l�Fa'7��O@����P������/�?��o,���W�����钋�x=�uGa��^3�w��CG��w�o�Z���熭�V|�o�ѭ�;4^�������]�v��;Rn���(ap�kם��ٖ��Y.�ON��U.q�����t��: ����@��:	6{F<ݙH�=�S�u0�S��i�]gh��<����~���T�^zڎ�wl�)�kZ�ݍ$�7ω���nٖ^��#пx���� �h7��}�?��PY�:�3�6�-�����d�����7�L�)�+ߤnZ�wm�������Z�Ž!j���{KP~���S7}����r�����gS��7I�\\k�����LQ�X~�h�Že�v����'�:�qq���J��j���ԺN���y�&�?��e���z���~����|���Ǻ�w��d�`��!�d3��Q�/fE�Ί��׾���ƛ2O[޵�דw�q]���RA3"�� 6��(֍�&���搪���Ɨ^�Z0N��>��Q��_���a��R�-��V1~a�j�'�t�ov���W��y���uXI��\~xU�7�낰c'˺;? �G�Iݸ���B%:�&+5��v��W�;ӿ���4'Wܘ� ��kć�����\��q��Ŧwl����S�iZd'�8���:�g������u�u~�a ]�-N2�ug��c\���$���,��!�s�5���5@a��4���������a+���{_Ƕ>b'M;G}�齡Ï������^�������7�֛l��hd$�R�J��6�5�K��9�נ��7Xn+Mo����~���.h�q���;7Ƿe���}�^{mX���"�i	Pݖ��;nW��h;�×q��N��ȇ��ţ�!>����=v��{{��˻/��Dvu_:7 �7N{�~'�e����v[�����i����v�
zh�o
e��0��2Ð�v_b����l"ΛC}-L�M��&���������0���K���Qï�/^z������b�j����d�����o�|�|�j|�w�770�k�G�^���䷱or�W�����/q�-:���oc�ѾƶK��b몯��ۺ��x�%�Q~��͟�|�n����osAt~S��:_�j0�b����~c{�g�6㰖���W�Z^Ԙ��7Ip���d�)���U��Z73���jqp���9�x�ص��E|�G���|���E>~����/���ά�_�K���_~.}_qM�R�������	5�7 QX�h~��^�N�n&{��N�o��v����s�K0^�a�_�;�A>��|���7���,�XAaZf7���ݵ8맴���/���m� �  
�:˫����5�n�}G������g}�s�� �^c���ݾ��g4e����D~��<}2�MŸ����Fu|=�su�/~=l�ibW�/V����@�;1��A���)�P�����u�� �+���`)���}_�������}Wh��%�}t:Ĳ�I�כ��B��x���d��Lf�t��?g���>���|���o;6�/��6g��?͖i�|��Au[�k4o�2�uy}���w��L�ie��DZ�T�(��]����n�}���<�����M����b�;u��}�-�|������W�3�o~���F�	5��vc�s��g��;n�5�nz�:�2�fՍ����̳�+���S"H�nQ�:{����&��W�����/�;��ߺ�yu�}U�Itے��
ş��_F9���Jb|����_d;7��v�������e~��Us����N7�-�ۃ�v=�KN xX��zmd��fm����f��0d�~$�~�w���oݗ���7޷��.\q3�`�S��K0X7P7�	L o/��R������h�͏f����1n�m�M�f��oR�'~�F�M�f��oB7�~�3��R�C��M�f��߄n�0�o�=�+�u1Ѽ0@N����R��ݗ�ߚK{�-�w�or:�m�(����(\~w�}~o�p��~��5�$L�>�>ަ�n�~?��Z�6���}�ѥ0��m�7�ް~D9�+�_�o�y���r��<��;Y�jJ������K�wg�7y�i1n�Pլ���Ҙ�m��`�B�a}����<�۬��oy��y�7yv݉���鮗C<��u+��;��ܻ��5�io��t�5��vW����Yr����=�C�������������߀{}���vcB�3��ńvA!�}�.�e}��l�+ Խ�1q	�N��m2���}���s_�����s�O\J��p�4�`8�����c��� !�&��k=��c�����j{�!��,�[a�C9<(���w��pc��Y�7�@���P��y��w��ۢ����<㛘ǩ��>����n��f����UZ�wY�Y�߽s����q�ƼcX��h뷂�LY^�Z�)�<�@P_��K��4sZ�}g�c�oʹF6
Ŀi9�{���~=���B��~a։��������l�/�Kk~��^�znY����\��o`����f~@����v��8
N@��|?���Q�Z����f\��s�q[L����.(�T�f=�jͨ�9�S�f> �u���3R�����7]i�}�G�w/t���*��D��9K�ϟ�>5{�q����L���ӧ�+�."�0b5g��G>Wn�dK���H��F�����7�D;���B��n��ӟ������_�_<����c5�mx����Qw��6��L��}�r[�k���.��)70���Y�-_?x����0d[�ZWQ���v��7/���4�o'��Q���3�y{6����g#l�p|_c2�7���t�:��|/�^�ҝ�0�+r[�V���N�e������M���'5����M̞���|��FUO��r��gh$~�:�Sn�s����C���7�۳��7z�3yӚ�(0;��{@u�κ��I"�{Y�����`5���"�����'x��ߴ�Y���]�l��O��(�[}�M��7��K��l��oo*��;X�YW�w��y9}��;<�U��Ę���~�>�h���Ho�6[��jķ6}�T���$0��w\�{^_������� ���      !   1   x�3�K�+IT.-H-2�,�2�
�%�&&g&�8���t� l�@      "   :   x�3�420�4424�74063��KJL�.-�tN,�IT�O�LTp/JLOMI����� I��      #   ,	  x�uY[�9��>E]`�T������x�{�R�.�����2DRd0�M7�5j���[��.��%}u]_M�עN:aj����n7� �����t͵������O��!��?�|>��>t]�"]����)|q��!��fb{�]�����ߎ?�ܾ��|����٦�h��M�u�tьց���ƽ�CU�l5�R�!�7/�y��|�p
��ީ��O#�0��$�7�ŝ�y��#��� �]]8���z��
�~""j]M�Ǭ�Kh���Bkd4T��j�FW�ZEõ�C�j6�/<��k<1��0�R.`��#��.�&���*p\|�0�p	4�����S,`�z�Ӓ�yǅj�Zk�7��M�0:�����<��5�l��I�>h^bLǫ�5w�x�»�p}�*$��w��l_�Һ^�}������v�����o��������q�Sz.�g�ʸV��~���е�2�	�S��\Բӽݽt�W�
��l:N�����d��t9�������G�~�Z��БW�7z�W?�I"�4��������%�(j�����v�Ⱥ9��D�/�҃���U�6��e��v���������~�G;Xw�lµ�E��h`��E_P����WQo�P拷:�˨K�Z�ș��JP�]��i�5i5˦Ә�MPP���bi��Dt>�&e��=�`�D1�^�b�d��ʸ�_�ޡ0m�K-NAY_��=a)�@c�Z���ٴ�hW�e�#�D:K��5���J��	��1������P�܀�c��T'�lrǚO�A7��/Ν� /q�,*k�´.�j���sZ�Vq�CփnK0��rm���L���#L1��lZ�v�1g���rn��h%�6fɵ:��q����,Qޭה���5�+Ά(��	A{	TH��P l�(ճ�&ƴ��l�q0�5L�[�W���
Aƚ,�w,�1��%��?��(��{uԬ�l�s�[o����-A�ڎ�C|tTJQZ6�_������pn�9P��+d���,���E .Y[xե�K���E���9��!��s��.I��F�c�N��\ZH�
��P���)`��-������J
�����ѐ Ϙ��1��<l �U˼���Q�X�45)M	���yp$����M���] �&���g���j*_�0��@r	�J9C��:�
ۚ�<&B�"�67#műYM#>.�齠y�)*y.O>���ږ��5�C�%�x�ē/U#z�s	l�C�LV�c0�if�Yې �)����J!��g�E���s?�ei�!l�y���=���!i�rO���C�Z�MT�P���O��/Tjٲ)?���DF�k��4>��X45�[���|e����fkv��M;��{�E��h@-��'\�-WA��w��� ��AR���9�	�H�������b:/K����c�pxa�aK|T�n�P�f����
E��0lUѾ��y�KtTp���$�et��ck慶�w��*X�G���3�(�O��;�fA�l�f�)$ކ��V8�B������8��"x�盗�Ӊ&F��p�+���z��pci^	kf�
��V&�$k��M{��$��Y�M���V��4a�h�GG9�\K������.a��l�70�{w!9�rB�&r��6dl�kg�`�9DO���sB��;�x0�~S\�՚���u������MG�k�i��x%�9j�<iq�g�I&�,�qD��k�'T��Oфbb~���f��iQ�e���V�;l�.���_�ۯ��T4�B������9Y�M'�h����U���:L[�,��ִ���Ơ(
��Wy�D�&���$����Yu�������d�ֶ�Y�×Ɠܑ�\c�wtdx��P��S�4��*"=��� �ӱx�"#>�Xو�h���iS�i�߇�Cc�����N�`�q"2lj� �+�5�N}a�M�C>�4�Ӳ�������9��fy�����P��p�����v	VԜ��A�l�#�N}vE�Pyw9m���/�ӛ�ovXt��VL{�F�O���x���K��'�=��EU�͈�Э�$�����x� hd{�
��C�29#�암�9C �@�i�>���}A��4��(!ҙ��c����m�:S&�.� ?uV��m:�i��T̩�9��h�V��s���S�e�d�ܫAэXns���ȧ������唝�濓�/��ޞ�ĸ���i"e}�
);�y��_�l�Hߟ��{��Dџ�n�� QC�D1`���z�L�$QZ�ӮU�pء�(�
�E%���8j5{��&B�t�Ú�orq�LO]���7K��N�_� n�q      $  