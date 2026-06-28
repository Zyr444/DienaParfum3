export default function ApplicationLogo(props) {
    return (
        <div className="flex items-center gap-2">
            <svg 
                viewBox="0 0 24 24" 
                fill="none" 
                stroke="currentColor" 
                strokeWidth="1.5" 
                strokeLinecap="round" 
                strokeLinejoin="round" 
                className="h-8 w-8 text-[#D4AF37]"
            >
                <path d="M12 2L15 8C17 9 20 9 22 10C21 13 18 15 15 16C12 17 9 17 6 16C3 15 0 13 0 10C2 9 5 9 7 8L12 2Z" fill="none"/>
                <path d="M12 22C12 22 10 18 10 15C10 12 12 10 12 10C12 10 14 12 14 15C14 18 12 22 12 22Z" fill="currentColor"/>
            </svg>
            <span className="text-lg font-serif tracking-wide text-gray-900 font-semibold">
                Diena Parfum
            </span>
        </div>
    );
}

