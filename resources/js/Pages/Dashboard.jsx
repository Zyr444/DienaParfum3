import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout';
import { Head, Link, usePage } from '@inertiajs/react';
import { useState } from 'react';

export default function Dashboard({ coupons = [], orders = [] }) {
    const user = usePage().props.auth.user;
    const [copiedCode, setCopiedCode] = useState(null);
    const [activeTab, setActiveTab] = useState('orders'); // default to orders tab

    const handleCopy = (code) => {
        navigator.clipboard.writeText(code);
        setCopiedCode(code);
        setTimeout(() => setCopiedCode(null), 2000);
    };

    const formatRupiah = (value) => {
        return new Intl.NumberFormat('id-ID', {
            style: 'currency',
            currency: 'IDR',
            minimumFractionDigits: 0,
            maximumFractionDigits: 0
        }).format(value);
    };

    const formatDate = (dateString) => {
        return new Date(dateString).toLocaleDateString('id-ID', {
            day: 'numeric',
            month: 'long',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
    };

    // Calculate quick stats
    const totalOrdersCount = orders.length;
    const pendingOrdersCount = orders.filter(o => o.status === 'new').length;
    const activeCouponsCount = coupons.length;

    // Helper to generate WA confirmation message
    const getWhatsAppUrl = (order) => {
        const phone = '6289531222146';
        const formattedTotal = formatRupiah(order.total_amount);
        let message = '';

        if (order.payment_status === 'unpaid') {
            message = `Halo Admin Diena Parfum,\n\nSaya ingin mengonfirmasi pembayaran untuk pesanan saya:\n*No. Pesanan:* #${order.order_number}\n*Total Transfer:* ${formattedTotal}\n\nMohon info detail rekening dan verifikasinya ya min. Terima kasih! ✦`;
        } else {
            message = `Halo Admin Diena Parfum,\n\nSaya ingin menanyakan status pengiriman untuk pesanan saya dengan nomor *#${order.order_number}*. Terima kasih! ✦`;
        }

        return `https://wa.me/${phone}?text=${encodeURIComponent(message)}`;
    };

    return (
        <AuthenticatedLayout
            header={
                <h2 className="text-xl font-serif leading-tight text-gray-900">
                    Hi, {user.name}!
                </h2>
            }
        >
            <Head title="Dashboard" />

            <div className="py-12 bg-gray-50 min-h-[calc(100vh-64px)]">
                <div className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8">
                    
                    {/* Welcome banner */}
                    <div className="relative overflow-hidden bg-black rounded-2xl p-8 mb-8 border border-[#D4AF37]/30 shadow-xl">
                        {/* Gold decorative gradient overlay */}
                        <div className="absolute right-0 top-0 -mt-12 -mr-12 w-64 h-64 bg-gradient-to-br from-[#D4AF37]/20 to-transparent rounded-full blur-3xl pointer-events-none"></div>
                        <div className="relative z-10">
                            <span className="text-[10px] uppercase tracking-[0.3em] text-[#D4AF37] font-semibold">Diena Parfum Club ✦</span>
                            <h1 className="text-3xl font-serif text-white mt-2 mb-3">Selamat Datang Kembali, {user.name}!</h1>
                            <p className="text-gray-400 text-sm max-w-2xl leading-relaxed">
                                Terima kasih telah menjadi pelanggan setia Diena Parfum. Pantau status pesanan parfum mewah Anda atau gunakan kupon diskon eksklusif di bawah ini.
                            </p>
                            <div className="mt-6 flex flex-wrap gap-4">
                                <Link 
                                    href="/" 
                                    className="inline-flex items-center px-5 py-2.5 bg-gradient-to-r from-[#FDE08B] to-[#D4AF37] text-black font-semibold text-xs uppercase tracking-widest rounded-lg hover:shadow-[0_0_15px_rgba(212,175,55,0.4)] transition-all"
                                >
                                    Belanja Sekarang
                                </Link>
                            </div>
                        </div>
                    </div>

                    {/* Quick Stats Cards */}
                    <div className="grid grid-cols-3 gap-6 mb-8 text-gray-900">
                        <div className="bg-white p-6 rounded-xl border border-gray-200 shadow-sm flex flex-col justify-between">
                            <span className="text-xs uppercase tracking-wider text-gray-400">Total Pesanan</span>
                            <span className="text-3xl font-bold font-serif text-gray-900 mt-2">{totalOrdersCount} <span className="text-xs font-normal text-gray-500">kali</span></span>
                        </div>
                        <div className="bg-white p-6 rounded-xl border border-gray-200 shadow-sm flex flex-col justify-between">
                            <span className="text-xs uppercase tracking-wider text-gray-400">Pesanan Pending</span>
                            <span className={`text-3xl font-bold font-serif mt-2 ${pendingOrdersCount > 0 ? 'text-amber-500' : 'text-gray-900'}`}>{pendingOrdersCount} <span className="text-xs font-normal text-gray-500">transaksi</span></span>
                        </div>
                        <div className="bg-white p-6 rounded-xl border border-gray-200 shadow-sm flex flex-col justify-between">
                            <span className="text-xs uppercase tracking-wider text-gray-400">Voucher Tersedia</span>
                            <span className="text-3xl font-bold font-serif text-gray-900 mt-2">{activeCouponsCount} <span className="text-xs font-normal text-gray-500">kupon</span></span>
                        </div>
                    </div>

                    {/* Navigation Tabs */}
                    <div className="flex border-b border-gray-200 mb-6">
                        <button
                            onClick={() => setActiveTab('orders')}
                            className={`py-3 px-6 font-semibold text-sm border-b-2 transition-all ${
                                activeTab === 'orders'
                                    ? 'border-[#D4AF37] text-[#D4AF37]'
                                    : 'border-transparent text-gray-500 hover:text-gray-900'
                            }`}
                        >
                            📦 Pesanan Saya ({totalOrdersCount})
                        </button>
                        <button
                            onClick={() => setActiveTab('vouchers')}
                            className={`py-3 px-6 font-semibold text-sm border-b-2 transition-all ${
                                activeTab === 'vouchers'
                                    ? 'border-[#D4AF37] text-[#D4AF37]'
                                    : 'border-transparent text-gray-500 hover:text-gray-900'
                            }`}
                        >
                            ✦ Voucher & Diskon ({activeCouponsCount})
                        </button>
                    </div>

                    {/* Tab Contents */}
                    <div>
                        {activeTab === 'vouchers' ? (
                            /* Vouchers Section */
                            <div>
                                <h3 className="text-lg font-serif text-gray-900 mb-6 flex items-center gap-2">
                                    <span className="text-[#D4AF37]">✦</span> Voucher & Diskon Spesial Untukmu
                                </h3>

                                {coupons.length === 0 ? (
                                    <div className="bg-white border border-gray-200 rounded-xl p-10 text-center shadow-sm">
                                        <svg className="mx-auto h-12 w-12 text-gray-300 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="1">
                                            <path strokeLinecap="round" strokeLinejoin="round" d="M9.75 9.75l4.5 4.5m0-4.5l-4.5 4.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                        </svg>
                                        <p className="text-gray-500 text-sm">Saat ini belum ada voucher aktif yang tersedia.</p>
                                    </div>
                                ) : (
                                    <div className="grid md:grid-cols-2 gap-6">
                                        {coupons.map((coupon) => (
                                            <div 
                                                key={coupon.id} 
                                                className="relative bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm flex flex-col justify-between hover:border-[#D4AF37]/50 transition-colors"
                                            >
                                                {/* Ticket side notches */}
                                                <div className="absolute left-0 top-1/2 -translate-y-1/2 w-4 h-8 bg-gray-50 rounded-r-full border-y border-r border-gray-200 z-10"></div>
                                                <div className="absolute right-0 top-1/2 -translate-y-1/2 w-4 h-8 bg-gray-50 rounded-l-full border-y border-l border-gray-200 z-10"></div>
                                                
                                                <div className="p-6 pb-4 flex gap-5 items-start">
                                                    {/* Voucher icon / percentage box */}
                                                    <div className="w-16 h-16 bg-black text-[#D4AF37] border border-[#D4AF37]/20 rounded-lg flex flex-col items-center justify-center font-bold text-center flex-shrink-0">
                                                        <span className="text-lg leading-none">
                                                            {coupon.type === 'percent' ? `${Math.floor(coupon.value)}%` : 'Rp'}
                                                        </span>
                                                        <span className="text-[9px] uppercase tracking-widest mt-1">
                                                            {coupon.type === 'percent' ? 'Off' : 'Disc'}
                                                        </span>
                                                    </div>

                                                    <div className="flex-1">
                                                        <span className="text-[10px] uppercase font-bold tracking-widest text-[#D4AF37]">
                                                            {coupon.type === 'percent' ? 'Potongan Persentase' : 'Potongan Harga'}
                                                        </span>
                                                        <h4 className="text-xl font-bold font-serif text-gray-900 mt-0.5">
                                                            {coupon.type === 'percent' 
                                                                ? `Diskon ${Math.floor(coupon.value)}%` 
                                                                : `Diskon ${formatRupiah(coupon.value)}`
                                                            }
                                                        </h4>
                                                        <p className="text-gray-500 text-xs mt-1.5 leading-relaxed">
                                                            Gunakan kode voucher ini pada saat melakukan checkout via WhatsApp untuk mengaktifkan potongan harga.
                                                        </p>
                                                    </div>
                                                </div>

                                                {/* Divider */}
                                                <div className="border-t border-dashed border-gray-200 mx-6"></div>

                                                {/* Code Copy Area */}
                                                <div className="p-4 bg-gray-50/50 px-6 flex justify-between items-center gap-4">
                                                    <div className="flex flex-col">
                                                        <span className="text-[9px] uppercase tracking-wider text-gray-400">Kode Voucher</span>
                                                        <span className="font-mono text-sm font-bold text-gray-800 tracking-wider select-all">
                                                            {coupon.code}
                                                        </span>
                                                    </div>
                                                    <button
                                                        onClick={() => handleCopy(coupon.code)}
                                                        className={`px-4 py-2 rounded-lg font-semibold text-xs uppercase tracking-widest transition-all ${
                                                            copiedCode === coupon.code
                                                                ? 'bg-green-600 text-white shadow-sm'
                                                                : 'bg-black text-white hover:bg-gray-800'
                                                        }`}
                                                    >
                                                        {copiedCode === coupon.code ? 'Tersalin ✓' : 'Salin Kode'}
                                                    </button>
                                                </div>
                                            </div>
                                        ))}
                                    </div>
                                )}
                            </div>
                        ) : (
                            /* Orders Section */
                            <div>
                                <h3 className="text-lg font-serif text-gray-900 mb-6 flex items-center gap-2">
                                    <span className="text-[#D4AF37]">📦</span> Riwayat Pesanan Parfum Anda
                                </h3>

                                {orders.length === 0 ? (
                                    <div className="bg-white border border-gray-200 rounded-xl p-10 text-center shadow-sm">
                                        <svg className="mx-auto h-12 w-12 text-gray-300 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="1">
                                            <path strokeLinecap="round" strokeLinejoin="round" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                                        </svg>
                                        <p className="text-gray-500 text-sm mb-4">Anda belum melakukan pemesanan parfum.</p>
                                        <Link 
                                            href="/" 
                                            className="inline-flex items-center px-4 py-2 bg-black text-white font-semibold text-xs uppercase tracking-widest rounded-lg hover:bg-gray-800 transition-colors"
                                        >
                                            Mulai Belanja
                                        </Link>
                                    </div>
                                ) : (
                                    <div className="space-y-6">
                                        {orders.map((order) => (
                                            <div 
                                                key={order.id} 
                                                className="bg-white border border-gray-200 rounded-xl shadow-sm overflow-hidden text-gray-800"
                                            >
                                                {/* Header Order */}
                                                <div className="bg-gray-50 border-b border-gray-100 p-6 flex flex-wrap justify-between items-center gap-4">
                                                    <div>
                                                        <span className="text-[10px] uppercase font-bold tracking-wider text-gray-400">Nomor Pesanan</span>
                                                        <h4 className="text-md font-bold font-mono text-gray-900">#{order.order_number}</h4>
                                                        <span className="text-xs text-gray-500 mt-1 block">
                                                            Dipesan pada: {formatDate(order.created_at)}
                                                        </span>
                                                    </div>
                                                    
                                                    {/* Status Badges */}
                                                    <div className="flex gap-2.5">
                                                        {/* Payment Status Badge */}
                                                        <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold ${
                                                            order.payment_status === 'paid' 
                                                                ? 'bg-green-100 text-green-800' 
                                                                : order.payment_status === 'unpaid' 
                                                                ? 'bg-amber-100 text-amber-800' 
                                                                : 'bg-red-100 text-red-800'
                                                        }`}>
                                                            {order.payment_status === 'paid' ? 'Lunas' : order.payment_status === 'unpaid' ? 'Belum Lunas' : 'Gagal'}
                                                        </span>

                                                        {/* Shipping Status Badge */}
                                                        <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold ${
                                                            order.status === 'new'
                                                                ? 'bg-blue-100 text-blue-800'
                                                                : order.status === 'process'
                                                                ? 'bg-indigo-100 text-indigo-800'
                                                                : order.status === 'shipped'
                                                                ? 'bg-orange-100 text-orange-800'
                                                                : order.status === 'delivered'
                                                                ? 'bg-emerald-100 text-emerald-800'
                                                                : 'bg-red-100 text-red-800'
                                                        }`}>
                                                            {order.status === 'new' 
                                                                ? 'Menunggu Konfirmasi WA' 
                                                                : order.status === 'process' 
                                                                ? 'Sedang Diproses' 
                                                                : order.status === 'shipped' 
                                                                ? 'Dikirim' 
                                                                : order.status === 'delivered' 
                                                                ? 'Selesai' 
                                                                : 'Dibatalkan'}
                                                        </span>
                                                    </div>
                                                </div>

                                                {/* Items List */}
                                                <div className="p-6 border-b border-gray-100 space-y-4">
                                                    {order.items && order.items.map((item) => (
                                                        <div key={item.id} className="flex items-center gap-4 justify-between">
                                                            <div className="flex items-center gap-4">
                                                                <div className="w-12 h-12 bg-gray-100 rounded-lg flex-shrink-0 border border-gray-200 overflow-hidden flex items-center justify-center">
                                                                    {item.product?.image ? (
                                                                        <img 
                                                                            src={item.product.image.startsWith('http') || item.product.image.startsWith('/') ? item.product.image : `/storage/${item.product.image}`} 
                                                                            alt={item.product.name} 
                                                                            className="object-cover w-full h-full"
                                                                        />
                                                                    ) : (
                                                                        <svg className="w-6 h-6 text-gray-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="1" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z" />
                                                                        </svg>
                                                                    )}
                                                                </div>
                                                                <div>
                                                                    <p className="font-semibold text-sm text-gray-900">{item.product?.name || 'Aroma Premium'}</p>
                                                                    <p className="text-xs text-gray-500">{item.quantity} x {formatRupiah(item.price)}</p>
                                                                </div>
                                                            </div>
                                                            <span className="text-sm font-semibold text-gray-900">{formatRupiah(item.amount)}</span>
                                                        </div>
                                                    ))}
                                                </div>

                                                {/* Summary & Action Button */}
                                                <div className="p-6 bg-gray-50/50 flex flex-wrap justify-between items-center gap-4">
                                                    <div className="flex gap-6 text-sm">
                                                        <div>
                                                            <span className="text-[10px] uppercase font-bold text-gray-400 block">Metode Pembayaran</span>
                                                            <span className="font-medium text-gray-700">Bank Transfer / Manual WA</span>
                                                        </div>
                                                        <div>
                                                            <span className="text-[10px] uppercase font-bold text-gray-400 block">Total Pembayaran</span>
                                                            <span className="font-bold text-[#D4AF37] font-serif text-lg">{formatRupiah(order.total_amount)}</span>
                                                        </div>
                                                    </div>

                                                    <div className="flex gap-3">
                                                        <a
                                                            href={getWhatsAppUrl(order)}
                                                            target="_blank"
                                                            className={`px-4 py-2 rounded-lg font-bold text-xs uppercase tracking-widest transition-all flex items-center gap-2 shadow-sm ${
                                                                order.payment_status === 'unpaid'
                                                                    ? 'bg-[#25D366] text-white hover:bg-[#20ba5a]'
                                                                    : 'bg-black text-white hover:bg-gray-800'
                                                            }`}
                                                        >
                                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51a12.8 12.8 0 0 0-.57-.01c-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 0 1-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 0 1-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 0 1 2.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0 0 12.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 0 0 5.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 0 0-3.48-8.413Z"/></svg>
                                                            {order.payment_status === 'unpaid' ? 'Konfirmasi Transfer WA' : 'Tanya Status WA'}
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        ))}
                                    </div>
                                )}
                            </div>
                        )}
                    </div>
                </div>
            </div>
        </AuthenticatedLayout>
    );
}
