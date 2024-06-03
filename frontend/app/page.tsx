'use client';

import React from 'react';
import useAuth from '../hooks/useAuth';

const HomePage = () => {
  const { isAuthenticated } = useAuth();

  if (!isAuthenticated) {
    return null; // or a loading spinner while redirecting
  }

  return (
    <div>
      <h1>Welcome to My Fullstack App</h1>
    </div>
  );
};

export default HomePage;
